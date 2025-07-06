local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s(
    "err",
    fmta(
      [[
        if err != nil {
          return <> err
        }
        <>
      ]],
      {
        i(0),
        i(1),
      }
    )
  ),
  s(
    "errf",
    fmta(
      [[
        if err != nil {
          return <> fmt.Errorf("<>: %w", err)
        }
        <>
      ]],
      {
        i(0),
        i(1, "error"),
        i(2),
      }
    )
  ),
}
