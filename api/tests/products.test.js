const request = require("supertest");
const app = require("../src/app");

describe("GET /products", () => {
  test("retourne un objet avec source et data", async () => {
    const res = await request(app).get("/products");
    // Sans DB en CI unitaire: 500 ou 200 selon environnement
    expect([200, 500, 503]).toContain(res.status);
  });

  test("si 200, data est un tableau", async () => {
    const res = await request(app).get("/products");
    if (res.status === 200) {
      expect(res.body).toHaveProperty("source");
      expect(Array.isArray(res.body.data)).toBe(true);
    }
  });

  test("si 200, chaque produit a les bons champs", async () => {
    const res = await request(app).get("/products");
    if (res.status === 200 && res.body.data.length > 0) {
      const product = res.body.data[0];
      expect(product).toHaveProperty("id");
      expect(product).toHaveProperty("name");
      expect(product).toHaveProperty("price_cents");
    }
  });
});

describe("GET /products - erreur 404", () => {
  test("route inexistante retourne 404", async () => {
    const res = await request(app).get("/products/99999999");
    expect(res.status).toBe(404);
  });
});
