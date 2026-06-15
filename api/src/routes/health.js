const express = require("express");
const db = require("../db");

const router = express.Router();

router.get("/", async (req, res) => {
  const checks = { api: "ok", database: "unknown" };
  let status = 200;

  try {
    await db.query("SELECT 1");
    checks.database = "ok";
  } catch (err) {
    checks.database = "error";
    status = 503;
  }

  res.status(status).json({
    status: status === 200 ? "ok" : "error",
    service: "shoplite-api",
    version: process.env.APP_VERSION || "unknown",
    environment: process.env.NODE_ENV || "development",
    checks,
    timestamp: new Date().toISOString(),
    uptime_seconds: Math.floor(process.uptime())
  });
});

router.get("/ready", async (req, res) => {
  try {
    await db.query("SELECT 1");
    res.status(200).json({ ready: true, database: "ok", timestamp: new Date().toISOString() });
  } catch (err) {
    res.status(503).json({ ready: false, database: "error", timestamp: new Date().toISOString() });
  }
});

module.exports = router;
