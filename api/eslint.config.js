const js = require("@eslint/js");

module.exports = [
  js.configs.recommended,
  {
    languageOptions: { ecmaVersion: 2022, globals: { process: true, console: true, require: true, module: true, __dirname: true } },
    rules: {
      "no-unused-vars": ["warn", { argsIgnorePattern: "^_|next" }],
      "no-console": "off"
    }
  }
];
