return {
  'L3MON4D3/LuaSnip',
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
    local ls = require("luasnip")
    local snip = ls.snippet
    local node = ls.snippet_node
    local text = ls.text_node
    local insert = ls.insert_node
    local func = ls.function_node
    local choice = ls.choice_node
    local dyn = ls.dynamic_node

    local js_ts_snips = {
      snip({ trig = "cl", dscr = "Print out to the console" },
        { text({ 'console.log(' }), insert(1), text({ ');' }), insert(2) }),
      snip({ trig = "fn", dscr = "Basic function declaration" },
        { text({ 'function ' }), insert(1), text({ "(" }), insert(2), text({ ') {', '\t' }), insert(3),
          text({ '\t', '};' }) })
    }

    local go_snips = {
      snip({ trig = "ife", dscr = "basic if err != nil {} boiler" },
        { text({ 'if err != nil { fmt.Printf("' }), insert(1), text({ ' ")}' }) }),
      snip('fn', {
        text({ 'func ' }), insert(1), text({ '() {' }), insert(2), text({ '};' })
      })
    }

    local tex = {
      -- text formatting
      snip({ trig = "bf", dscr = "Create bold text" },
        { text({ '\\textbf{' }), insert(1), text({ '}' }) }),
      snip({ trig = "it", dscr = "Create italic text" },
        { text({ '\\textit{' }), insert(1), text({ '}' }) }),
      snip({ trig = "tt", dscr = "Create typewriter text" },
        { text({ '\\texttt{' }), insert(1), text({ '}' }) }),
      snip({ trig = "ul", dscr = "Create underlined text" },
        { text({ '\\underline{' }), insert(1), text({ '}' }) }),
      snip({ trig = "em", dscr = "Create emphasized text" },
        { text({ '\\emph{' }), insert(1), text({ '}' }) }),

      -- dots
      snip({ trig = "dots", dscr = "Create dots" },
        { text({ '\\dots' }) }),

      -- new line
      snip({ trig = "nl", dscr = "Create new line" },
        { text({ '\\\\' }) }),
      --
      -- create expression
      snip({ trig = "exp", dscr = "Create expression" },
        { text({ '$ ' }), insert(1), text({ ' $' }) }),
      -- create block expression
      snip({ trig = "bexp", dscr = "Create block expression" },
        { text({ '\\[ ' }), insert(1), text({ ' \\]' }) }),

      -- fractions
      snip({ trig = "frac", dscr = "Create expression fraction" },
        { text({ '\\frac{' }), insert(1), text({ '}{' }), insert(2), text({ '}' }) }),
      snip({ trig = "lfrac", dscr = "Create line fraction" },
        { text({ '$ \\frac{' }), insert(1), text({ '}{' }), insert(2), text({ '} $' }) }),
      snip({ trig = "bfrac", dscr = "Create block fraction" },
        { text({ '\\[ \\frac{' }), insert(1), text({ '}{' }), insert(2), text({ '} \\]' }) }),
      snip({ trig = "tfrac", dscr = "Create text fraction" },
        { text({ '\\frac{\\text{' }), insert(1), text({ '}}{\\text{' }), insert(2), text({ '}}' }) }),

      -- binomial
      snip({ trig = "binom", dscr = "Create binomial expression" },
        { text({ '\\binom{' }), insert(1), text({ '}{' }), insert(2), text({ '}' }) }),
      snip({ trig = "lbinom", dscr = "Create line binomial" },
        { text({ '$ \\binom{' }), insert(1), text({ '}{' }), insert(2), text({ '} $' }) }),
      snip({ trig = "bbinom", dscr = "Create block binomial" },
        { text({ '\\[ \\binom{' }), insert(1), text({ '}{' }), insert(2), text({ '} \\]' }) }),

      -- brackets
      snip({ trig = "br", dscr = "Create round brackets" },
        { text({ '(' }), insert(1), text({ ')' }) }),
      snip({ trig = "sqbr", dscr = "Create square brackets" },
        { text({ '[' }), insert(1), text({ ']' }) }),
      snip({ trig = "crbr", dscr = "Create curly brackets" },
        { text({ '\\left\\{' }), insert(1), text({ '\\right\\}' }) }),
      snip({ trig = "abr", dscr = "Create angle brackets" },
        { text({ '\\langle ' }), insert(1), text({ ' \\rangle' }) }),
      snip({ trig = "vbr", dscr = "Create vertical bars" },
        { text({ '\\left|' }), insert(1), text({ '\\right|' }) }),
      snip({ trig = "vbr", dscr = "Create double vertical bars" },
        { text({ '\\left\\|' }), insert(1), text({ '\\right\\|' }) }),

      -- sizes
      snip({ trig = "big1", dscr = "Create big size 1" },
        { text({ '\\Bigl ' }), insert(1), text({ ' \\Bigr' }) }),
      snip({ trig = "big2", dscr = "Create big size 2" },
        { text({ '\\biggl ' }), insert(1), text({ ' \\biggr' }) }),
      snip({ trig = "big3", dscr = "Create big size 3" },
        { text({ '\\Biggl ' }), insert(1), text({ ' \\Biggr' }) }),

      -- exponents and subscripts
      snip({ trig = "exp", dscr = "Create exponent" },
        { insert(1), text({ '^' }), insert(2), }),
      snip({ trig = "sub", dscr = "Create subscript" },
        { insert(1), text({ '_' }), insert(2), }),

      -- roots
      snip({ trig = "sqrt", dscr = "Create square root" },
        { text({ '\\sqrt{' }), insert(1), text({ '}' }) }),
      snip({ trig = "root", dscr = "Create nth root" },
        { text({ '\\sqrt[' }), insert(1), text({ ']{' }), insert(2), text({ '}' }) }),

      -- logarithms
      snip({ trig = "log", dscr = "Create logarithm" },
        { text({ '\\log_{' }), insert(1), text({ '}{' }), insert(2), text({ '}' }) }),
      snip({ trig = "ln", dscr = "Create natural logarithm" },
        { text({ '\\ln ' }), insert(1), text({ ' ' }) }),
    }


    local date = function() return { os.date('%Y-%m-%d') } end

    ls.add_snippets(nil, {
      all = {
        snip({
          trig = "date",
          namr = "Date",
          dscr = "Date in the form of YYYY-MM-DD",
        }, {
          func(date, {}),
        }),
      },
      go = go_snips,
      javascript = js_ts_snips,
      typescript = js_ts_snips,
      tex = tex,
    })
  end,
}
