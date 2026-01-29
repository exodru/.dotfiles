-- order matters! options sets leaderkey before loading lazy
require("settings.options")
require("config.lazy")
-- keymaps after lazy, so that we have the plugins loaded before we can access them (telescope.builtin etc.)
require("settings.keymaps")
