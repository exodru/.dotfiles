local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("tex", {

	-- ============================
	-- Paragraph & text formatting
	-- ============================

	s("bf", { t("\\textbf{"), i(1), t("}") }),
	s("it", { t("\\textit{"), i(1), t("}") }),
	s("quote", { t("\\begin{quote}"), t({ "", "" }), i(1), t({ "", "\\end{quote}" }) }),

	-- ============================
	-- Sections & subsections
	-- ============================

	s("sec", { t("\\section{"), i(1), t("}") }),
	s("ssec", { t("\\subsection{"), i(1), t("}") }),
	s("sssec", { t("\\subsubsection{"), i(1), t("}") }),

	-- ============================
	-- Math / Notation
	-- ============================

	s("set", { t("\\{ "), i(1, "elements"), t(" \\}") }),
	s("Rset", { t("\\mathbb{R}") }),
	s("Zset", { t("\\mathbb{Z}") }),
	s("Nset", { t("\\mathbb{N}") }),
	s("E", { t("\\mathbb{E}") }),
	s("Var", { t("\\mathrm{Var}("), i(1), t(")") }),
	s("Pr", { t("\\mathrm{Pr}("), i(1), t(")") }),

	s("sum", { t("\\sum_{"), i(1, "i=1"), t("}^{"), i(2, "n"), t("} "), i(3) }),
	s("prod", { t("\\prod_{"), i(1, "i=1"), t("}^{"), i(2, "n"), t("} "), i(3) }),
	s("frac", { t("\\frac{"), i(1), t("}{"), i(2), t("}") }),

	-- ============================
	-- Code / Algorithm blocks
	-- ============================

	s("code", { t({ "\\begin{verbatim}", "" }), i(1), t({ "", "\\end{verbatim}" }) }),
	s("lst", {
		t({ "\\begin{lstlisting}[language=" }),
		i(1, "Python"),
		t({ "]", "" }),
		i(2, "# code here"),
		t({ "", "\\end{lstlisting}" }),
	}),
	s("algo", {
		t({ "\\begin{algorithm}", "\\caption{" }),
		i(1, "Algorithm name"),
		t("}"),
		t({ "", "\\begin{algorithmic}" }),
		t({ "", "" }),
		i(2),
		t({ "", "\\end{algorithmic}", "\\end{algorithm}" }),
	}),

	-- ============================
	-- Citing / bibliography
	-- ============================

	s("cite", { t("\\cite{"), i(1, "key"), t("}") }),
	s("foot", { t("\\footnote{"), i(1), t("}") }),

	-- ============================
	-- Discrete math
	-- ============================

	s("forall", { t("\\forall "), i(1), t(" \\in "), i(2) }),
	s("exists", { t("\\exists "), i(1), t(" \\in "), i(2) }),
	s("impl", { t(" \\implies "), i(1) }),
	s("iff", { t(" \\iff "), i(1) }),
	s("setunion", { t("\\bigcup_{"), i(1), t("} "), i(2) }),
	s("setinter", { t("\\bigcap_{"), i(1), t("} "), i(2) }),

	-- ============================
	-- Algorithms & Pseudocode helpers
	-- ============================

	s("if", { t("\\If{"), i(1), t("}{"), i(2), t("}") }),
	s("else", { t("\\Else{"), i(1), t("}") }),
	s("for", { t("\\For{"), i(1), t("}{"), i(2), t("}") }),
	s("while", { t("\\While{"), i(1), t("}{"), i(2), t("}") }),

	-- ============================
	-- Misc / helper
	-- ============================

	s("label", { t("\\label{"), i(1, "label_name"), t("}") }),
	s("ref", { t("\\ref{"), i(1, "label_name"), t("}") }),
})
