const request = require("supertest");
const app = require("../src/app");

describe("GET /", () => {
  test("retourne le nom de l'API", async () => {
    const res = await request(app).get("/");
    expect(res.status).toBe(200);
    expect(res.body.name).toBe("ShopLite API");
    expect(res.body.endpoints).toContain("/health");
  });
});

describe("GET /health", () => {
  test("retourne status ok avec les champs requis", async () => {
    const res = await request(app).get("/health");
    expect(res.status).toBeLessThan(600);
    expect(res.body).toHaveProperty("status");
    expect(res.body).toHaveProperty("service", "shoplite-api");
    expect(res.body).toHaveProperty("checks");
    expect(res.body).toHaveProperty("timestamp");
    expect(res.body).toHaveProperty("version");
  });

  test("retourne les champs api et database dans checks", async () => {
    const res = await request(app).get("/health");
    expect(res.body.checks).toHaveProperty("api", "ok");
    expect(res.body.checks).toHaveProperty("database");
  });
});

describe("GET /health/ready", () => {
  test("retourne un champ ready", async () => {
    const res = await request(app).get("/health/ready");
    expect(res.body).toHaveProperty("ready");
    expect(res.body).toHaveProperty("timestamp");
  });
});

describe("GET /route-inexistante", () => {
  test("retourne 404", async () => {
    const res = await request(app).get("/route-inexistante");
    expect(res.status).toBe(404);
    expect(res.body).toHaveProperty("error");
  });
});
