return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    scroll = {
      enabled = true,
      -- Primary scroll animation settings (more noticeable)
      animate = {
        duration = {
          step = 15,   -- Longer steps for smoother animation
          total = 300, -- Longer total duration (more noticeable)
        },
        easing = "outQuad", -- Smoother deceleration effect
      },
      -- Repeated scroll animation (after initial scroll)
      animate_repeat = {
        delay = 100, -- Delay before repeat animation kicks in (ms)
        duration = {
          step = 10,
          total = 100, -- Slightly longer for repeat scrolling
        },
        easing = "outQuad",
      },
    },
  },
}
