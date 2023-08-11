\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{scinote}[2023/08/05 My Custom Class for LaTeX]
\LoadClass[11pt,twoside]{book}

\RequirePackage[mono=false]{libertine} % new linux font, ignore mono

\RequirePackage{luatex85}

%\renewcommand{\baselinestretch}{1.05}
\RequirePackage{amsmath,amsthm,amssymb,mathrsfs,amsfonts,dsfont}
\RequirePackage{epsfig,graphicx}
\RequirePackage{tabularx}
\RequirePackage{blkarray}
\RequirePackage{slashed}
\RequirePackage{color}
\RequirePackage{listings}
\RequirePackage{caption}
% \RequirePackage{fullpage}
\RequirePackage{lipsum} % provides dummy text for testing
\RequirePackage[toc,title,titletoc,header]{appendix}
\RequirePackage{minitoc}
\RequirePackage{color}
\RequirePackage{multicol} % two-col ToC
\RequirePackage{bm}
\RequirePackage{imakeidx} % before hyperref
\RequirePackage{hyperref}
% link colors settings
\hypersetup{
	colorlinks=true,
	citecolor=magenta,
	linkcolor=blue,
	filecolor=green,
	urlcolor=cyan,
	% hypertexnames=false,
}

\RequirePackage{siunitx}
\sisetup{%
	mode                = match,
	propagate-math-font = true,
	reset-math-version  = false,
	reset-text-family   = false,
	reset-text-series   = false,
	reset-text-shape    = false,
	text-family-to-math = true,
	text-series-to-math = true,
}

\RequirePackage{booktabs}
\RequirePackage{xcolor}
\RequirePackage[automake, acronym, style=super, toc, shortcuts]{glossaries-extra}
\setabbreviationstyle[acronym]{long-short}

\RequirePackage[capitalise]{cleveref}
\RequirePackage{subcaption}
\RequirePackage{enumitem}
\RequirePackage{mathtools}
\RequirePackage{physics}
\RequirePackage[linesnumbered,ruled,vlined,algosection]{algorithm2e}
\newcommand\mycommfont[1]{\footnotesize\ttfamily\textcolor{blue}{#1}} % https://tex.stackexchange.com/questions/162207/algorithm2e-comment-style
\SetCommentSty{mycommfont}
% \SetCommentSty{textsf}
\RequirePackage{epigraph}
\epigraphwidth=1.0\linewidth
\epigraphrule=0pt

% adjust margin
\RequirePackage[margin=2.3cm]{geometry}
\headheight13.6pt

%%%%%%%%%%%%%%%% thmtools %%%%%%%%%%%%%%%%%%%%%
\RequirePackage{thmtools}
\declaretheorem[numberwithin=chapter]{theorem}
\declaretheorem[numberwithin=chapter]{axiom}
\declaretheorem[numberwithin=chapter]{lemma}
\declaretheorem[numberwithin=chapter]{proposition}
\declaretheorem[numberwithin=chapter]{claim}
\declaretheorem[numberwithin=chapter]{conjecture}
\declaretheorem[sibling=theorem]{corollary}
\declaretheorem[numberwithin=chapter, style=definition]{definition}
\declaretheorem[numberwithin=chapter, style=definition]{problem}
\declaretheorem[numberwithin=chapter, style=definition]{example}
\declaretheorem[numberwithin=chapter, style=definition]{exercise}
\declaretheorem[numberwithin=chapter, style=definition]{observation}
\declaretheorem[numberwithin=chapter, style=definition]{fact}
\declaretheorem[numberwithin=chapter, style=definition]{construction}
\declaretheorem[numberwithin=chapter, style=definition]{remark}
\declaretheorem[numberwithin=chapter, style=remark]{question}
%%%%%%%%%%%%%%%% thmtools %%%%%%%%%%%%%%%%%%%%%
\RequirePackage{changepage}
\newenvironment{solution}
{\renewcommand\qedsymbol{$\square$}\color{blue}\begin{adjustwidth}{0em}{2em}\begin{proof}[\textit Solution.~]}
			{\end{proof}\end{adjustwidth}}

%%%%%%%%%%%%%%%% index %%%%%%%%%%%%%%%%%%%%%
\begin{filecontents}{index.ist}
	% https://tex.stackexchange.com/questions/65247/index-with-an-initial-letter-of-the-group
	headings_flag 1
	heading_prefix "{\\centering\\large \\textbf{"
		heading_suffix "}}\\nopagebreak\n"
	delim_0 "\\nobreak\\dotfill"
\end{filecontents}
\newcommand{\myindex}[1]{\index{#1} \emph{#1}}
\makeindex[columns=3, intoc, title=Alphabetical Index, options= -s index.ist]
%%%%%%%%%%%%%%%% index %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% ToC %%%%%%%%%%%%%%%%%%%%%
% Link Chapter title to ToC: https://tex.stackexchange.com/questions/32495/linking-the-section-text-to-the-toc
\RequirePackage[explicit]{titlesec}
\titleformat{\chapter}[display]
{\normalfont\huge\bfseries}{\chaptertitlename\ {\thechapter}}{20pt}{\hyperlink{chap-\thechapter}{\Huge#1}
\addtocontents{toc}{\protect\hypertarget{chap-\thechapter}{}}}
\titleformat{name=\chapter,numberless}
{\normalfont\huge\bfseries}{}{-20pt}{\Huge#1}

%%%%%%%%%%%%%%%%%%% fancyhdr %%%%%%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\pagestyle{fancy} % enable fancy page style
\renewcommand{\headrulewidth}{0.0pt} % comment if you want the rule
\fancyhf{} % clear header and footer
\fancyhead[lo,le]{\leftmark}
\fancyhead[re,ro]{\rightmark}
\fancyfoot[CE,CO]{\hyperref[toc-contents]{\thepage}}

% https://tex.stackexchange.com/questions/550520/making-each-page-number-link-back-to-beginning-of-chapter-or-section
\makeatletter
\def\chaptermark#1{\markboth{\protect\hyper@linkstart{link}{\@currentHref}{Chapter \thechapter ~ #1}\protect\hyper@linkend}{}}
\def\sectionmark#1{\markright{\protect\hyper@linkstart{link}{\@currentHref}{\thesection ~ #1}\protect\hyper@linkend}}
\makeatother
%%%%%%%%%%%%%%%%%%% fancyhdr %%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%% biblatex %%%%%%%%%%%%%%%%%
\RequirePackage[doi=false,url=false,isbn=false,style=alphabetic,backend=biber,backref=true]{biblatex}
\addbibresource{bib.bib}

\newbibmacro{string+doiurlisbn}[1]{%
	\iffieldundef{doi}{%
		\iffieldundef{url}{%
			\iffieldundef{isbn}{%
				\iffieldundef{issn}{%
					#1%
				}{%
					\href{http://books.google.com/books?vid=ISSN\thefield{issn}}{#1}%
				}%
			}{%
				\href{http://books.google.com/books?vid=ISBN\thefield{isbn}}{#1}%
			}%
		}{%
			\href{\thefield{url}}{#1}%
		}%
	}{%
		\href{http://dx.doi.org/\thefield{doi}}{#1}%
	}%
}

% https://tex.stackexchange.com/questions/94089/remove-quotes-from-inbook-reference-title-with-biblatex
\DeclareFieldFormat[article,incollection,inproceedings,book,misc]{title}{\usebibmacro{string+doiurlisbn}{\mkbibemph{#1}}}
% https://tex.stackexchange.com/questions/454672/biblatex-journal-name-non-italic
\DeclareFieldFormat{journaltitle}{#1\isdot}
\DeclareFieldFormat{booktitle}{#1\isdot}
% https://tex.stackexchange.com/questions/10682/suppress-in-biblatex
\renewbibmacro{in:}{}
% add video field: https://tex.stackexchange.com/questions/111846/biblatex-2-custom-fields-only-one-is-working
\DeclareSourcemap{
	\maps[datatype=bibtex]{
		\map{
			\step[fieldsource=video]
			\step[fieldset=usera,origfieldval]
		}
	}
}
\DeclareFieldFormat{usera}{\href{#1}{\textsc{Online video}}}
\AtEveryBibitem{
	\csappto{blx@bbx@\thefield{entrytype}}{% put at end of entry
		\iffieldundef{usera}{}{\space \printfield{usera}}
	}
}

\endinput


