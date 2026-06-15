const { v4: uuidv4 } = require("crypto").randomUUID ? { v4: () => require("crypto").randomUUID() } : { v4: () => Math.random().toString(36).slice(2) };

const SENSITIVE = [/password/i, /token/i, /secret/i, /authorization/i, /cookie/i];

function sanitize(obj) {
  if (!obj || typeof obj !== "object") return obj;
  return Object.fromEntries(
    Object.entries(obj).map(([k, v]) =>
      SENSITIVE.some(r => r.test(k)) ? [k, "***"] : [k, v]
    )
  );
}

function getLevel(statusCode) {
  if (statusCode >= 500) return "error";
  if (statusCode >= 400) return "warn";
  return "info";
}

module.exports = function logger(req, res, next) {
  const requestId = req.headers["x-request-id"] || require("crypto").randomUUID();
  req.requestId = requestId;
  res.setHeader("x-request-id", requestId);

  const startedAt = Date.now();

  res.on("finish", () => {
    const level = getLevel(res.statusCode);
    const entry = {
      level,
      request_id: requestId,
      method: req.method,
      path: req.originalUrl,
      status: res.statusCode,
      duration_ms: Date.now() - startedAt,
      user_agent: req.headers["user-agent"] || null,
      timestamp: new Date().toISOString()
    };
    console.log(JSON.stringify(entry));
  });

  next();
};
