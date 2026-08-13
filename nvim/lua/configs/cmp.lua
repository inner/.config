local cmp = require "cmp"

local options = require "nvchad.configs.cmp"

-- Keep arrow keys acting like normal cursor movement until the completion
-- menu is visible. Once IntelliSense is open, they select menu items like
-- they would in a typical IDE.
options.mapping["<Down>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    fallback()
  end
end, { "i", "s" })

options.mapping["<Up>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback()
  end
end, { "i", "s" })

return options
