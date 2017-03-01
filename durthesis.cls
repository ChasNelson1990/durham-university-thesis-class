% This is the durthesis class that gives a format of the thesis % according to the Durham University Regulations (https://www.dur.ac.uk/graduate.school/current-students/submissionandbeyond/thesis.submission/preparing.thesis/format/). To use it delcare \documentclass{durthesis} at the beginning of your latex thesis.
% Optional: provide a style file called thesis.sty
% Based on dmathesis.cls by M. Imran (2001/06/18).
% Last Modified by Chas Nelson, Durham University, 2015.
\NeedsTeXFormat{LaTeX2e}[2011/06/27]
\ProvidesClass{durthesis}[2016]

%% Required for Options
\RequirePackage[a4paper]{geometry}
\RequirePackage{setspace}
\RequirePackage{xparse,xkeyval,calc}
\RequirePackage{multicol}

%% Initialise Option Variables
\newcommand\@fontsize{10pt}
\newcommand\@printstate{final}

%% Set core fontsize & declare font-size options as per Durham Regulations
\DeclareOption{12pt}{\renewcommand\@fontsize{12pt}}
\DeclareOption{11pt}{\renewcommand\@fontsize{11pt}}
\DeclareOption{10pt}{\renewcommand\@fontsize{10pt}}

%% Declare print state options
\newif\if@printstate\@printstatefalse
\DeclareOption{final}{\@printstatetrue}
\DeclareOption{draft}{\@printstatefalse}

%% Choose colourspace
\DeclareOption{rgb}{}
\DeclareOption{cmyk}{}
\DeclareOption{grey}{}
\DeclareOption{bw}{}

%% Default Options
\ExecuteOptions{10pt,final,rgb}

%% Process Options
\ProcessOptions\relax

%% Load base class
\if@printstate
     \LoadClass[\@fontsize,twoside,a4paper]{report}
    %  Set Margins as per Durham Regulations
    \geometry{a4paper,includeheadfoot}
    % 1.5 Spacing for Final Document
    \onehalfspacing
\else
    \LoadClass[draft,\@fontsize,a4paper]{report}
    %  Set Margins to 1.5cm all and have margin notes in page.
    \geometry{a4paper,includeall,margin=1.5cm}
    % Double Spacing for Draft
    \doublespacing
    % Add Watermark
    \usepackage{background}
    \backgroundsetup{contents={DRAFT}}
    % Check References
    \usepackage{refcheck}
    % Line Numbers
    \usepackage{lineno}
    \modulolinenumbers[5]
    \linenumbers
    % Show Overfull HBoxes
    \overfullrule=2cm
    % Externalise tikzpictures
    % \usetikzlibrary{external}
    % \tikzexternalize[mode=list only]
\fi

%% Required Packages
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\graphicspath{{./.bodies/}{./images/}}
\RequirePackage{pgffor}
\RequirePackage{calc}
\RequirePackage[UKenglish]{babel}
\usepackage[utf8]{inputenc}
\RequirePackage[UKenglish]{isodate}
\RequirePackage{csquotes}
\RequirePackage[    backend=biber,
                                style=nature,
                                backref=true,
                                backrefstyle=two,
                                abbreviate=false,
                                maxnames = 100,
                            ]{biblatex}
\DefineBibliographyStrings{english}{%
    backrefpage  = {\textit{\lowercase{p}.}}, % for single page number
    backrefpages = {\textit{\lowercase{p}p.}} % for multiple page numbers
}

%% Import Thesis Styles
\RequirePackage{thesis}

%% Redefinition of maketitle
\def\Bodies{DU}
\renewcommand*{\maketitle}{
    \begin{titlepage}
    \begin{center}
        \vfill

        % Title
        {\Huge\bf\@title\unskip\strut\par}

        % Author
        \vskip20pt
        {\LARGE\bf\@author\unskip\par}

        \vfill
        {\Large A thesis presented for the degree of\\
        Doctor of Philosophy at Durham University}
        \vskip40pt

        % Groups and Institutes, with Logos
        %% Logo Bar
  		\newcounter{numLogo}
		\setcounter{numLogo}{0}%
		\foreach \body in \Bodies{%
			\stepcounter{numLogo}%
		}%
        \foreach \body in \Bodies{%
            \begin{minipage}[t][][t]{0.9\linewidth/\the\value{numLogo}}
                \centering
                \includegraphics[width=0.95\linewidth,height=2cm,keepaspectratio=true]{\body}

                \small \input{.bodies/\body}
            \end{minipage}
        }%
        \vskip40pt
        \@date\par
        \vskip40pt
    \end{center}
    \end{titlepage}
}

%%  Redefinition  of Contents and Lists
\makeatletter
\renewcommand{\@dotsep}{2}
\newcommand \Dotfill {\leavevmode \cleaders \hb@xt@ 2mm{\hss .\hss }\hfill \kern \z@}

%%  Redefinition  \tableofcontents  in  report.cls
\renewcommand\tableofcontents{%
    {\setlength{\parskip}{0mm plus0mm minus0mm}%remove unneccessary white space
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname}%
    \addcontentsline{toc}{chapter}{\numberline{}\contentsname}
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }}

%%  Redefinition \listoffigures in report.cls
\renewcommand\listoffigures{%
    {\setlength{\parskip}{0mm plus0mm minus0mm}%remove unneccessary white space
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    \addcontentsline{toc}{chapter}{\numberline{}\listfigurename}
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }}

%%  Redefinition \listoftables in report.cls
\renewcommand\listoftables{%
    {\setlength{\parskip}{0mm plus0mm minus0mm}%remove unneccessary white space
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    \addcontentsline{toc}{chapter}{\numberline{}\listtablename}
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }}

    %%  Redefinition \listofalgorithms in report.cls
    \newcommand{\listalgorithmname}{List of Algorithms}
    \renewcommand\listofalgorithms{%
        {\setlength{\parskip}{0mm plus0mm minus0mm}%remove unneccessary white space
        \if@twocolumn
          \@restonecoltrue\onecolumn
        \else
          \@restonecolfalse
        \fi
        \chapter*{\listalgorithmname}%
        \addcontentsline{toc}{chapter}{\numberline{}\listalgorithmname}
        \@starttoc{loa}%
        \if@restonecol\twocolumn\fi
    }}

% %% Redefinition thebibliograph in report.cls
% \renewenvironment{thebibliography}[1]{
%     {\setlength{\parskip}{0mm plus0mm minus0mm}%remove unneccessary white space
%     \chapter*{\bibname
%         \@mkboth{\bibname}{\bibname}}%
%     \list{\@biblabel{\@arabic\c@enumiv}}{
%         \settowidth\labelwidth{\@biblabel{#1}}%
%         \leftmargin\labelwidth
%         \advance\leftmargin\labelsep
%         \@openbib@code
%         \usecounter{enumiv}%
%         \let\p@enumiv\@empty
%         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
%     \sloppy
%     \clubpenalty4000
%     \@clubpenalty \clubpenalty
%     \widowpenalty4000%
%     \sfcode`\.\@m}}
% {\def\@noitemerr
%     {\@latex@warning{Empty `thebibliography' environment}}%
%     \endlist}
%
% %% Redefinition of nocite (due to standalone clash)
% \makeatletter
% \def\@documentnocite#1{\@bsphack
%   \@for\@citeb:=#1\do{%
%     \edef\@citeb{\expandafter\@firstofone\@citeb}%
%     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
%     \@ifundefined{b@\@citeb}{\G@refundefinedtrue
%       \@latex@warning{Citation `\@citeb' undefined}}{}}%
%   \@esphack}
% \AtBeginDocument{\let\nocite\@documentnocite}
% \makeatother

%% Macros to allow title/author use throughout document
\def\title#1{\gdef\@title{#1}\gdef\THETITLE{#1}}
\def\author#1{\gdef\@author{#1}\gdef\THEAUTHOR{#1}}

%% Redefine main abstract based on default report environment
\if@titlepage
  \renewenvironment{abstract}{%
      \titlepage
      \null\vfil
      \@beginparpenalty\@lowpenalty
      \addcontentsline{toc}{chapter}{\numberline{}Abstract}
      \begin{center}%
        \textbf{\Large \THETITLE}

        \textbf{\large \THEAUTHOR}

        {\large Submitted for the degree of Doctor of Philosophy\\ March 2017}

        \@endparpenalty\@M
      \end{center}}%
     {\par\vfil\null\endtitlepage}
\else
  \renewenvironment{abstract}{%
      \addcontentsline{toc}{chapter}{\numberline{}Abstract}
      \begin{center}
        \textbf{\Large \THETITLE}

        \textbf{\large \THEAUTHOR}

        {\large Submitted for the degree of Doctor of Philosophy\\ March 2017}
      \end{center}

      \if@twocolumn
        %
      \else
        \small
        \begin{center}%
          {}%
        \end{center}%
        \quotation
      \fi}
      {\if@twocolumn\else\endquotation\fi}
    \newpage
\fi
\makeatother

%% Declaration Environment
\newenvironment{declaration}[0]{
    \chapter*{Declaration}
    \addcontentsline{toc}{chapter}{\numberline{}Declaration}
}{
    \vfill
    \noindent \textbf{Copyright \copyright\; \the\year\ by \THEAUTHOR}.\\
    ``The copyright of this thesis rests with the author.  No quotations
    from it should be published without the author's prior written consent
    and information derived from it should be acknowledged''.
    \newpage
}

%% Acknowledgements Environment
\def\Funders{}
\newenvironment{acknowledgements}[0]{
    \chapter*{Acknowledgements}
    \addcontentsline{toc}{chapter}{\numberline{}Acknowledgements}
}{
    \vfill
    \begin{center}
    % Funding Bodies, with Logos
    %% Logo Bar
    \newcounter{numFund}
    \setcounter{numFund}{0}%
    \foreach \body in \Funders{%
        \stepcounter{numFund}%
    }%
        \foreach \body in \Funders{%
            \begin{minipage}[t][][t]{0.9\linewidth/\the\value{numFund}}
                \centering
                \includegraphics[width=0.95\linewidth,height=2cm,keepaspectratio=true]{\body}
            \end{minipage}
        }%
    \end{center}
    \newpage
}

%% Dedications Environment
\newenvironment{dedication}[0]{
    \chapter*{Dedication}
    \addcontentsline{toc}{chapter}{\numberline{}Dedication}
}{
    \newpage
}

%% Set-Up Chapter Titles
% \usepackage{titlesec}
% \titleclass{\chapter}{page}
% \assignpagestyle{\chapter}{empty}
% \titleformat{\chapter}
%     [display]
%     {\LARGE\bfseries}
%     {\chaptername\ \thechapter}
%     {0pt}
%     {\Large}
%     [\clearpage]

%% Chapter Abstract Environment
\newenvironment{chapabstract}[0]{
  \begin{center}
  \begin{minipage}{0.8\textwidth}
}{
  \end{minipage}
  \end{center}
  \newpage
}

%% Chapter Prologue Environment
\newenvironment{prologue}[0]{
  \section*{Prologue}
  \addcontentsline{toc}{section}{\numberline{}Prologue}
  \addtocontents{toc}{\smallskip}
  \thispagestyle{logue}
}{
  % \newpage
}
%% Chapter epilogue Environment
\newenvironment{epilogue}[0]{
  % \newpage
  \section*{Epilogue}
  \addtocontents{toc}{\smallskip}
  \addcontentsline{toc}{section}{\numberline{}Epilogue}
  \thispagestyle{logue}
}{
}

%% Define bold font in math mode from original dmathesis
\def\bv#1{\mbox{\boldmath$#1$}}

%% Set Paragraph Indent and Skip, Adjust Spacing for Headings
\setlength{\parindent}{0cm}
\setlength{\parskip}{5mm plus3mm minus2mm}%TODO:Fix spacing so consistent for lists, headings and such
\usepackage{titlesec}
\titlespacing\chapter{0pt}{\parskip}{-\parskip}
\titlespacing\section{0pt}{\parskip}{-\parskip}
\titlespacing\subsection{0pt}{\parskip}{-\parskip}
\titlespacing\subsubsection{0pt}{\parskip}{-\parskip}

%% Set Header and Footer Layouts
\pagestyle{fancy}
\renewcommand{\sectionmark}[1]{ \markright{#1} }
\fancyhf{}
\fancyhead[LE,RO]{\thepage}
\fancyhead[RE]{\textit{ \nouppercase{\chaptername~\thechapter}} }
\fancyhead[LO]{\textit{ \nouppercase{\rightmark}} }
\fancypagestyle{plain}{ %
  \fancyhf{} % remove everything
  \fancyhead[LE,RO]{\thepage}
  % \renewcommand{\headrulewidth}{0pt} % remove lines as well
  \renewcommand{\footrulewidth}{0pt}
}
\fancypagestyle{logue}{ %
    \fancyhf{}
    \fancyhead[LE,RO]{\thepage}
    \fancyhead[RE]{\textit{ \nouppercase{\chaptername~\thechapter}} }
    \fancyhead[LO]{ }
}

%% Colours
\definecolor{blackC}{HTML}{321F20}%#321F20
\definecolor{palatine}{HTML}{7E317B}%#7E317B
\definecolor{255C}{HTML}{7E317B}%#7E317B
\definecolor{257C}{HTML}{D8ACE0}%#D8ACE0
\definecolor{634C}{HTML}{006388}%#006388
\definecolor{201C}{HTML}{AA2B4A}%#AA2B4A
\definecolor{5655C}{HTML}{CFDAD1}%#CFDAD1
\definecolor{290C}{HTML}{C4E5FA}%#C4E5FA
\definecolor{5835C}{HTML}{9FA161}%#9FA161
\definecolor{459C}{HTML}{E8E391}%#E8E391
\definecolor{675C}{HTML}{C43B8E}%#C43B8E
\definecolor{5493C}{HTML}{91B8BD}%#91B8BD
\definecolor{warmgrey8C}{HTML}{968E85}%#968E85
\definecolor{ustinov}{HTML}{003865}%#003865
\definecolor{josephinebutler}{HTML}{D22630}%#D22630

% %% Define Declaration macro for chapter starts
% \DeclareDocumentCommand\declaration{m}{%
%     \begin{flushright}
%         \textit{The work described in this chapter was published in~\cite{#1}.\\}
%     \end{flushright}
% }

\endinput
