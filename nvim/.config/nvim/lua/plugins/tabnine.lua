return {
  "tzachar/cmp-tabnine",
  enabled = false,
  config = function()
    require("cmp_tabnine.config"):setup({ silent = true })
  end,
}
