\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{halecture}[2012/02/10 v0.2 lecture class (Holger Arndt)]

\LoadClass[paper=a4,fontsize=17pt,pagesize,titlepage=true,headings=normal,
headsepline=true,bibliography=totoc,bibliography=openstyle,
numbers=noendperiod]{scrreprt}
\typearea{25}

\RequirePackage{etex}

\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{calculator}

\newboolean{englishif}
\DeclareOption{english}{\setboolean{englishif}{true}}
\DeclareOption{german}{\setboolean{englishif}{false}}

\newboolean{colourif}
\DeclareOption{colour}{\setboolean{colourif}{true}}
\DeclareOption{nocolour}{\setboolean{colourif}{false}}

\newboolean{blanksif}
\DeclareOption{noblanks}{\setboolean{blanksif}{false}}
\DeclareOption{blanks}{\setboolean{blanksif}{true}}

\newboolean{webif}
\DeclareOption{noweb}{\setboolean{webif}{false}}
\DeclareOption{web}{\setboolean{webif}{true}}
\ExecuteOptions{noweb}

\newboolean{inputif}
\DeclareOption{noshort}{\setboolean{inputif}{true}}
\DeclareOption{short}{\setboolean{inputif}{false}}

\newboolean{dejavuif}
\DeclareOption{dejavu}{\setboolean{dejavuif}{true}}
\DeclareOption{freesans}{\setboolean{dejavuif}{false}}
\ExecuteOptions{freesans}

\ProcessOptions

\RequirePackage{xltxtra}
\RequirePackage{csquotes}
\RequirePackage[babelshorthands]{polyglossia}

\RequirePackage{makeidx}

\ifthenelse{\boolean{englishif}}{%
  \RequirePackage[backend=biber,sortlocale=en,sorting=anyt,language=english,%
  bibstyle=alphabetic,citestyle=alphabetic,maxbibnames=99,minnames=3%
  ]{biblatex}}{%
  \RequirePackage[backend=biber,sortlocale=de,sorting=anyt,language=german,%
  bibstyle=alphabetic,citestyle=alphabetic,maxbibnames=99,minnames=3]{biblatex}}

\RequirePackage{microtype}

\ifthenelse{\boolean{englishif}}{%
  \RequirePackage[english]{minitoc}}{%
  \RequirePackage[ngermanb]{minitoc}}
%% \usepackage{mtcoff}  %% schaltet die minitocs aus

%% \RequirePackage{amscd}
%% \RequirePackage[all]{xy}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{dcolumn}
\RequirePackage{alltt}
\RequirePackage{enumitem}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{mleftright}

% % \makeatletter  \def\m@th{\mathsurround\z@\color{black}} \makeatother
% % \RequirePackage{everyhook}
% % \PushPostHook{display}{\color{mathcol}}
% % \everymath{\color{mathcol}}
\newcommand{\mathcol}{\color{mathcol}}
% % \newboolean{notblackif}
% % \setboolean{notblackif}{false}
% % \everymath{\ifthenelse{\boolean{notblackif}}{}{\mathcol}}
% \everymath{\mathcol}
% % \everydisplay{\mathcol}
% \let\origBeginDisplay\[
%   \let\origEndDisplay\]
% % \newcommand{\myBeginDisplay}{\origBeginDisplay\begingroup%
% % \ifthenelse{\boolean{notblackif}}{}{%
% % \mathcol}}
% \newcommand{\myBeginDisplay}{\origBeginDisplay\begingroup\mathcol}
% \newcommand{\myEndDisplay}{\endgroup\origEndDisplay}
% \let\[\myBeginDisplay
%   \let\]\myEndDisplay
\RequirePackage[math-style=ISO,bold-style=ISO,mathbf=sym,mathrm=sym]{unicode-math}

% \ifthenelse{\boolean{blanksif} \or \not \boolean{colourif}}{%
\setmathfont[AutoFakeBold=3.5,StylisticSet={1}]{XITS Math}
% \setmathfont[version=bold,FakeBold=3.5]{XITS Math}
% \setmathfont[range={"1D49C},StylisticSet=1]{XITS Math}%𝒜
% \setmathfont[range={"1D4A6},StylisticSet=1]{XITS Math}%𝒦
% \setmathfont[range={"1D4AA},StylisticSet=1]{XITS Math}%𝒪
% \setmathfont[range={"2133},StylisticSet=1]{XITS Math}%ℳ
% \setmathfont[range={"1D4AB},StylisticSet=1]{XITS Math}%𝒫
% \setmathfont[range={"1D4AF},StylisticSet=1]{XITS Math}%𝒯
% \setmathfont[range={"1D4B5},StylisticSet=1]{XITS Math}%𝒵
% }{%
%   \setmathfont[Color=009000]{XITS Math}
%   \setmathfont[Color=009000,version=bold,FakeBold=3.5]{XITS Math}
%   \setmathfont[Color=009000,range={"1D49C},StylisticSet=1]{XITS Math}
%   \setmathfont[Color=009000,range={"1D4AA},StylisticSet=1]{XITS Math}
%   \setmathfont[Color=009000,range={"1D4AF},StylisticSet=1]{XITS Math}
% }

\RequirePackage{multicol}
\RequirePackage{xspace}
\RequirePackage[mode=text,per-mode=fraction,binary-units=true]{siunitx}

\RequirePackage{scrdate}
\RequirePackage{scrtime}
% \RequirePackage{scrpage2}
\RequirePackage[autooneside=false]{scrlayer-scrpage}

\RequirePackage{color}
\RequirePackage{xcolor}
\pagecolor{white}
\RequirePackage{graphicx}
% \PassOptionsToPackage{hyphens}{url}
\RequirePackage[bookmarksnumbered,bookmarksopen,plainpages=false,unicode=true]{hyperref}
\RequirePackage{dotlessj}
\RequirePackage{pdfpages}
\RequirePackage{ccicons}
\RequirePackage{ulem}
% \RequirePackage{pstricks}
% \RequirePackage{framed}
\RequirePackage[thmmarks,amsmath,hyperref]{ntheorem}
% \RequirePackage[ntheorem,xcolor]{mdframed}

\ifthenelse{\boolean{englishif}}{%
  \setmainlanguage{english}}{%
  \setmainlanguage{german}}

\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
% \setmonofont[Ligatures=NoCommon]{TeX Gyre Cursor}
% \setmonofont{FreeMono}
\setmonofont[Scale=0.9,Ligatures=NoCommon]{DejaVu Sans Mono}
% \setmainfont[Scale=0.9]{TeX Gyre Heros}
\ifthenelse{\boolean{dejavuif}}{%
  \setmainfont[Scale=0.87]{DejaVu Sans Condensed}
  \setsansfont[Scale=0.87]{DejaVu Sans Condensed}
}{%
  % \setmainfont[Scale=1,FakeStretch=0.87]{DejaVu Sans Condensed}}{%
  % \setmainfont[Scale=0.92]{FreeSans}%
  \setmainfont[Scale=0.92,Path=/home/wmai20/holger/.fonts/,
  BoldFont=FreeSansBold.otf,ItalicFont=FreeSansOblique.otf]{FreeSans.otf}%
  \setsansfont[Scale=0.92,Path=/home/wmai20/holger/.fonts/,
  BoldFont=FreeSansBold.otf,ItalicFont=FreeSansOblique.otf]{FreeSans.otf}%
}
% \setmainfont[Scale=0.9]{Liberation Sans}
% \newfontfamily\myroman{FreeSerif}
\newfontfamily\myroman[Scale=0.87]{DejaVu Serif Condensed}
\newfontfamily\myromanalt[Scale=0.94]{FreeSerif}
\newfontfamily\myromanmath[Scale=1]{XITS}
% \newfontfamily\mybb{XITS Math}
% \setmathfont(Digits,Latin,Greek)[Scale=1]{FreeSerif}
% \setmathrm[Scale=1]{FreeSerif}
\setmathtt{TeX Gyre Cursor}

\RequirePackage[CJK,Devanagari,Gothic,Thai,TransportAndMapSymbols]{ucharclasses}
\newfontfamily{\thaifont}[Scale=0.8]{Droid Sans Thai}
\setTransitionsFor{Thai}{\begingroup\thaifont}{\endgroup}
\newfontfamily{\chinesefont}{WenQuanYi Micro Hei}
\setTransitionsForCJK{\begingroup\chinesefont}{\endgroup}
\newfontfamily\indicfont{Lohit Devanagari}
\setTransitionsForDevanagari{\begingroup\indicfont}{\endgroup}
\newfontfamily\gothicfont{FreeSerif}
\setTransitionsFor{Gothic}{\begingroup\gothicfont}{\endgroup}
\newfontfamily\emojifont{Twitter Color Emoji}
% \newfontfamily\emojifont{EmojiOne Color}
\setTransitionsFor{TransportAndMapSymbols}{\begingroup\emojifont}{\endgroup}
\newcommand{\disablefontchange}{\uccoff}

\pagestyle{scrheadings}
\clearscrheadfoot
\automark[section]{chapter}
\ihead{\footnotesize\textcolor{black}{\leftmark}}
\ohead{%
  \footnotesize\textcolor{black}{\rightmark}
  \normalsize
  \quad
  \pagemark%
  \setcounter{totalpage}{\value{beforechappage}+\value{page}-1+\value{picpage}+\value{xtrapage}}%
  \makebox[0mm][l]{\startHide\textcolor{totalpagecol}{\footnotesize(\arabic{totalpage})}\stopHide}%
  \addtocounter{totalpage}{1}
}
\deftripstyle{chheadings}{\textcolor{white}{%
    \footnotesize\textcolor{black}{{\leftmark}}}}{}{%
  \quad
  \pagemark%
  \setcounter{totalpage}{\value{beforechappage}+\value{page}-1+\value{picpage}+\value{xtrapage}}%
  \makebox[0mm][l]{\textcolor{totalpagecol}{\footnotesize(\arabic{totalpage})}}%
  \addtocounter{totalpage}{1}
}{}{}{}
\renewcommand{\chapterpagestyle}{chheadings}

\setlength{\parindent}{0pt}
\setlength{\parskip}{3mm}

\newcommand{\lecthypersetup}{%
  \hypersetup{%
    pdftitle={\lectpdftitle},
    pdfauthor={\lectpdfauthor},
    pdfpagemode=UseThumbs,
    colorlinks=true,
    linkcolor=linkcol,
    citecolor=citecol,
    urlcolor=urlcol,
    menucolor=menucol,
    filecolor=filecol
  }
}

\input{mycolours}
\RequirePackage{collistings}

\RequirePackage{halecbib}

\setcounter{tocdepth}{5}
\setcounter{minitocdepth}{5}
\renewcommand{\mtifont}{\color{minitoccol}\large\sffamily\bfseries}
\renewcommand{\mtcfont}{\color{minitoccol}\small\sffamily}
\renewcommand{\mtcSfont}{\color{minitoccol}\small\sffamily\bfseries}
\renewcommand{\mtcSSfont}{\color{minitoccol}\small\sffamily}
\renewcommand{\mtcSSSfont}{\color{minitoccol}\small\sffamily}
\renewcommand{\mtcPfont}{\color{minitoccol}\footnotesize\sffamily}
\renewcommand{\mtcSPfont}{\color{minitoccol}\footnotesize\sffamily}
\renewcommand{\kernafterminitoc}{\kern-.3\baselineskip\kern.5ex}
\nomtcpagenumbers
% \mtcsetpagenumbers{*}{off} % klappt seit TeXLive 2016 beides nicht → immer Seitenzahlen

\makeindex

\newcommand{\inputif}[1]{\ifthenelse{\boolean{inputif}}{\input{#1}}{%
    \typeout{input
      ausgelassen!}$◀▶$}}

\newfont{\hidemarkfont}{zptmcm7y}
\newcommand{\startHide}{\color{hidecol}%
  \definecolorif{lstblack}{rgb}{0.40,0.10,0.50}}
\newcommand{\stopHide}{}
\newenvironment{Hide}{\startHide}{\stopHide}
%% Manchmal setzen Seitenumbrueche die Farbe auf schwarz zurueck, dann
%% hilft folgendes weiter
\newcommand{\EnsureHide}{%
  \color{hidecol}%
}
\newcommand{\includegraphicsHide}[2]{%
  \makebox[0mm]{\hidemarkfont H\,\symbol{127}\hspace*{10mm}}%
  \includegraphics[#1]{#2}%
}
\ifthenelse{\boolean{blanksif}}{%
  \renewcommand{\startHide}{%
    \definecolor{emcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{cmtcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{mathcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{myred}{rgb}{1.00,1.00,1.00}%
    \definecolor{myblue}{rgb}{1.00,1.00,1.00}%
    \definecolor{mygreen}{rgb}{1.00,1.00,1.00}%
    \definecolor{mymagenta}{rgb}{1.00,1.00,1.00}%
    \definecolor{mycyan}{rgb}{1.00,1.00,1.00}%
    \definecolor{myyellow}{rgb}{1.00,1.00,1.00}%
    \definecolor{linkcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstblack}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstkeywordcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstndkeywordcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstidentifiercol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstcommentcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstjavadoccol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lststringcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstdirectivecol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstnumbercol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstprocnamecol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstmanualemphcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstinteractcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{lstinteractcol}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigBlue}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigBlueIII}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigrownIII}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigGreen}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigGreenIII}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigmagentaII}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigMagentaIII}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigMagentaIV}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigRed}{rgb}{1.00,1.00,1.00}%
    \definecolor{xfigRedII}{rgb}{1.00,1.00,1.00}%
    \color{hiddenwhite}%
    \special{pdf: literal 1 0 0 1 2000 2000 cm}%
  }
  \renewcommand{\stopHide}{%
    \special{pdf: literal 1 0 0 1 -2000 -2000 cm}%
  }
  \renewcommand{\EnsureHide}{\color{hiddenwhite}}
  \renewcommand{\includegraphicsHide}[2]{%
    \EnsureHide\includegraphics[#1,draft]{#2}}
}{}
\newcommand{\selectgraphics}[3]{%
  \ifthenelse{\boolean{blanksif}}{%
    \includegraphics[#1]{#3}}{%
    \includegraphicsHide{#1}{#2}}}
\newcommand{\selectinput}[2]{%
  \ifthenelse{\boolean{blanksif}}{%
    \input{#2}}{%
    \makebox[0mm]{\hidemarkfont S\,\symbol{127}\hspace*{10mm}}%
    \input{#1}}}

\newcommand{\startWebHide}{}
\newcommand{\stopWebHide}{}
\newenvironment{WebHide}{\startWebHide}{\stopWebHide}
\newcommand{\includegraphicsWebHide}[2]{%
  \includegraphics[#1]{#2}%
}
\ifthenelse{\boolean{webif}}{%
  \renewcommand{\startWebHide}{%
    \color{hiddenwhite}%
    \special{pdf: literal 1 0 0 1 2000 2000 cm}%
  }
  \renewcommand{\stopWebHide}{%
    \special{pdf: literal 1 0 0 1 -2000 -2000 cm}%
  }
  \renewcommand{\includegraphicsWebHide}[2]{%
    \color{hiddenwhite}\includegraphics[#1,draft]{#2}}
}{}

\let\origRef\ref
\newcommand{\refif}[1]{\ifthenelse{\NOT\boolean{inputif}}{%
    #1}{\ref{#1}}}

\newcommand{\seccol}[1]{\textcolor{seccol}{#1}}
\newcommand{\emcol}[1]{\textcolor{emcol}{#1}}

\setcounter{secnumdepth}{5}

\let\origEmph\emph
\renewcommand{\emph}[1]{\textbf{\emcol{#1}}}

\addtokomafont{sectioning}{\rmfamily\color{seccol}}
% \renewcommand{\chapterheadstartvskip}{\vspace*{2\baselineskip}\vspace*{-30mm}}
\renewcommand{\chapterheadstartvskip}{\vspace*{2\baselineskip}\vspace*{-20mm}}

\newcommand{\typechaptername}[1]{\typeout{[@#1]}}

\newboolean{intoc}
\setboolean{intoc}{false}
\newcounter{toclen}
\newcounter{beforechappage}
\setcounter{beforechappage}{1}
\newcounter{totalpage}
\let\origTableofcontents\tableofcontents
\let\origPrintindex\printindex
\let\origChapter\chapter
\renewcommand{\chapter}[1]{%
  \newpage
  \renewcommand{\thepage}{\arabic{chapter}-\arabic{page}}
  \addtocounter{beforechappage}{\value{page}}
  \addtocounter{beforechappage}{-1}
  \ifthenelse{\boolean{intoc}}{\setcounter{toclen}{\value{page}}}{}
  \setboolean{intoc}{false}    
  \setcounter{page}{1}
  \typechaptername{#1}
  \origChapter{#1}
  % \vspace*{30mm}
  \minitoc
}
\newcommand{\smallchapter}[1]{%
  \newpage
  \setboolean{intoc}{false}    
  \renewcommand{\thepage}{\arabic{chapter}-\arabic{page}}
  \addtocounter{beforechappage}{\value{page}}
  \addtocounter{beforechappage}{-1}
  \setcounter{page}{1}
  \typechaptername{#1}
  \origChapter{#1}
}
\newcommand{\appchapter}[1]{%
  \clearpage
  \setboolean{intoc}{false}    
  \renewcommand{\thepage}{\Alph{chapter}-\arabic{page}}
  \addtocounter{beforechappage}{\value{page}}
  \addtocounter{beforechappage}{-1}
  \setcounter{page}{1}
  \typechaptername{#1}
  \origChapter{#1}
}
\let\newChapter\chapter
\newcommand{\emptybibliography}{%
  \let\chapter\origChapter
  \newpage
  \setboolean{intoc}{false}    
  \renewcommand{\thepage}{Ref-\arabic{page}}
  \addtocounter{beforechappage}{\value{page}}
  \addtocounter{beforechappage}{-1}
  \setcounter{page}{1}
  \typechaptername{Bibliography}
  \addchap{\bibname}
  % \adjustmtc
  \let\chapter\newChapter}
\renewcommand{\tableofcontents}{%
  \let\chapter\origChapter
  \setboolean{intoc}{true}
  \ifthenelse{\boolean{englishif}}{%
    \renewcommand{\thepage}{Cont-\arabic{page}}}{%
    \renewcommand{\thepage}{Inh-\arabic{page}}}
  \addtocounter{beforechappage}{\value{page}}
  \addtocounter{beforechappage}{-1}
  \setcounter{page}{1}
  \typechaptername{Contents}
  \origTableofcontents
  \let\chapter\newChapter}
\renewcommand{\printindex}{%
  \let\chapter\origChapter
  \renewcommand{\indexpagestyle}{chheadings}
  \newpage
  \setboolean{intoc}{false}    
  \renewcommand{\thepage}{Idx-\arabic{page}}
  \addtocounter{beforechappage}{\value{page}}
  \addtocounter{beforechappage}{-1}
  \setcounter{page}{1}
  \typechaptername{Index}
  \origPrintindex
  \let\chapter\newChapter}

\defbibheading{minitoc}{\minisec{#1}}

\let\origParagraph\paragraph
\renewcommand{\paragraph}[1]{\origParagraph{#1}\hfill\nopagebreak}
\let\origSubparagraph\subparagraph
\renewcommand{\subparagraph}[1]{\origSubparagraph{#1}\hfill\nopagebreak}

% \renewcommand\sectionlinesformat[4]{%
% \colorbox[rgb]{0.8,0.8,0.8}{%
% \parbox[t]{\dimexpr\textwidth-2\fboxsep\relax}{%
% \raggedsection\color{seccol}\@hangfrom{#3}{#4}%
% }}}

\theoremheaderfont{\color{excol}\bfseries}
\theorembodyfont{}
\theoremseparator{:}
\newcommand{\thmrules}{%
  \theoremprework{{\textcolor{excol}{\rule{\textwidth}{1mm}}}}
  \theorempostwork{{\textcolor{excol}{\rule[2.5ex]{\textwidth}{0.5mm}}}}}
\thmrules\newtheorem{definition}{Definition}[chapter]
\thmrules\newtheorem{satz}[definition]{Satz}
\thmrules\newtheorem{theorem}[definition]{Theorem}
\thmrules\newtheorem{satzdefinition}[definition]{Satz und Definition}
\thmrules\newtheorem{lemma}[definition]{Lemma}
\thmrules\newtheorem{korollar}[definition]{Korollar}
\thmrules\newtheorem{corollary}[definition]{Corollary}
\thmrules\newtheorem{beispiel}[definition]{Beispiel}
\thmrules\newtheorem{example}[definition]{Example}
\thmrules\newtheorem{beispiele}[definition]{Beispiele}
\thmrules\newtheorem{examples}[definition]{Examples}
\thmrules\newtheorem{bemerkung}[definition]{Bemerkung}
\thmrules\newtheorem{remark}[definition]{Remark}
\thmrules\newtheorem{bemerkungen}[definition]{Bemerkungen}
\thmrules\newtheorem{remarks}[definition]{Remarks}
\thmrules\newtheorem{algorithmus}[definition]{Algorithmus}
\thmrules\newtheorem{quiz}[definition]{Quiz}
\thmrules\newtheorem{aufgabe}{Aufgabe}[chapter]
\thmrules\newtheorem{exercise}{Exercise}[chapter]
\thmrules\newtheorem*{inhziel}{Inhalt/Ziele}
\thmrules\newtheorem*{contgoal}{Contents/Goals}
\thmrules\newtheorem*{frage}{Frage}
\thmrules\newtheorem*{fragen}{Fragen}
\thmrules\newtheorem*{problem}{Problem}
\theoremsymbol{\ensuremath{\textcolor{excol}{\blacksquare}}}
\thmrules\newtheorem*{beweisskizze}{Beweisskizze}
\thmrules\newtheorem*{proofsketch}{Proof sketch}
\thmrules\newtheorem*{beweis}{Beweis}
\thmrules\newtheorem*{proof}{Proof}
\thmrules\newtheorem*{beweisdessatzes}{Beweis des Satzes}

\newcommand{\newSemester}[2][show]{%
  \newcounter{reachedpage#2}
  \ifthenelse{\equal{#1}{hide}}{%
    \setcounter{reachedpage#2}{-1}}{}
  \newcounter{reachedindexentry#2}
  \setcounter{reachedindexentry#2}{10}% ab 10: erlaubt alphabetische
  % Sortierung von bis zu 90 Einträgen
}

\newcounter{lectpages}
\newcommand{\Reached}[3]{%
  \ifthenelse{\value{reachedpage#1}>-1}{%
    \marginpar{\textcolor{reachedcol}{\makebox[5mm][r]{%
          \footnotesize #1: #2 \rule{5mm}{1ex}}}}%
    \ifthenelse{\value{reachedpage#1}=0}{%
      \setcounter{reachedpage#1}{\value{toclen}}%
      \addtocounter{reachedpage#1}{-1}%
    }{}
    \setcounter{lectpages}{\value{totalpage}-\value{reachedpage#1}}
    \setcounter{reachedpage#1}{\value{totalpage}}
    \refstepcounter{reachedindexentry#1}
    \index{达#1@#1!\arabic{reachedindexentry#1}@Vorlesung #2 (#3, \arabic{lectpages} S.)}}{}}
\newcommand{\ReachedUniAtHome}[3]{%
  \ifthenelse{\value{reachedpage#1}>-1}{%
    \marginpar{\textcolor{reachedcol}{\makebox[5mm][r]{%
          \footnotesize #1: #2 (Uni@Home)\rule{5mm}{1ex}}}}%
    \ifthenelse{\value{reachedpage#1}=0}{%
      \setcounter{reachedpage#1}{\value{toclen}}%
      \addtocounter{reachedpage#1}{-1}%
    }{}
    \setcounter{lectpages}{\value{totalpage}-\value{reachedpage#1}}
    \setcounter{reachedpage#1}{\value{totalpage}}
    \refstepcounter{reachedindexentry#1}
    \index{达#1@#1!\arabic{reachedindexentry#1}@Vorlesung #2 (Uni"@Home) (#3, \arabic{lectpages} S.)}}{}}
\newcommand{\ReachedReading}[3]{%
  \ifthenelse{\value{reachedpage#1}>-1}{%
    \marginpar{\textcolor{reachedcol}{\makebox[5mm][r]{%
          \footnotesize #1: #2 (read)\rule{5mm}{1ex}}}}%
    \ifthenelse{\value{reachedpage#1}=0}{%
      \setcounter{reachedpage#1}{\value{toclen}}%
      \addtocounter{reachedpage#1}{-1}%
    }{}
    \setcounter{lectpages}{\value{totalpage}-\value{reachedpage#1}}
    \setcounter{reachedpage#1}{\value{totalpage}}
    \refstepcounter{reachedindexentry#1}
    \index{达#1@#1!\arabic{reachedindexentry#1}@Vorlesung #2 (read) (#3, \arabic{lectpages} S.)}}{}}
\newcommand{\ReachedZoom}[3]{%
  \ifthenelse{\value{reachedpage#1}>-1}{%
    \marginpar{\textcolor{reachedcol}{\makebox[5mm][r]{%
          \footnotesize #1: #2 (Zoom)\rule{5mm}{1ex}}}}%
    \ifthenelse{\value{reachedpage#1}=0}{%
      \setcounter{reachedpage#1}{\value{toclen}}%
      \addtocounter{reachedpage#1}{-1}%
    }{}
    \setcounter{lectpages}{\value{totalpage}-\value{reachedpage#1}}
    \setcounter{reachedpage#1}{\value{totalpage}}
    \refstepcounter{reachedindexentry#1}
    \index{达#1@#1!\arabic{reachedindexentry#1}@Vorlesung #2 (Zoom) (#3, \arabic{lectpages} S.)}}{}}
\newcommand{\Skipped}[1]{%
  \ifthenelse{\value{reachedpage#1}>-1}{%
    \marginpar{\textcolor{reachedcol}{\makebox[5mm][r]{%
          \footnotesize #1: xx \rule{5mm}{1ex}}}}%
    \setcounter{lectpages}{\value{totalpage}-\value{reachedpage#1}}
    \setcounter{reachedpage#1}{\value{totalpage}}
    \refstepcounter{reachedindexentry#1}
    \index{达#1@#1!\arabic{reachedindexentry#1}@ausgelassen (\arabic{lectpages} S.)}}{}}
\ifthenelse{\boolean{blanksif}}{%
  \renewcommand{\Reached}[3]{}
  \renewcommand{\ReachedUniAtHome}[3]{}
  \renewcommand{\ReachedReading}[3]{}
  \renewcommand{\ReachedZoom}[3]{}
  \renewcommand{\Skipped}[1]{}
}

\let\origIncludegraphics\includegraphics
\renewcommand{\includegraphics}[2][]{\ifthenelse{\boolean{colourif}}{%
    \origIncludegraphics[#1]{#2}}{%
    \origIncludegraphics[#1]{#2_bw}}}

\newcommand{\includecompletepdfwrap}[1]{\includepdf[pages=-]{#1}}
\newcommand{\includecompletepdf}[1]{\ifthenelse{\boolean{colourif}}{%
    \includecompletepdfwrap{#1}}{%
    \let\myIncludegraphics\includegraphics
    \let\includegraphics\origIncludegraphics
    \includecompletepdfwrap{#1_bw}%
    \let\includegraphics\myIncludegraphics}}

\newcounter{picpage}
\setcounter{picpage}{0}
\newboolean{pagehidden}
\setboolean{pagehidden}{false}
\newcommand{\pngpage}[2][]{%
  \addtocounter{picpage}{1}
  \addtocounter{page}{-1}
  \ifthenelse{\boolean{englishif}}{%
    \renewcommand{\thepage}{Pic-\arabic{picpage}}}{%
    \renewcommand{\thepage}{Bild-\arabic{picpage}}}%
  \ifthenelse{\boolean{colourif} \and \not \boolean{webif}}{%
    \pagecolor{black}}{}%
  \let\newIncludegraphics\includegraphics%
  \let\includegraphics\origIncludegraphics%
  \ifthenelse{\boolean{pagehidden} \and \boolean{webif}}{%
    \includepdf[picturecommand={%
      \put(820,580){\makebox(0,0)[tr]{\href{run:#2.png}{\scriptsize\mygreen{#2}}}}%
      % \put(820,570){\makebox(0,0)[tr]{\scalebox{0.7}{\mygreen{#1}}}}%
    },scale=0]{#2.png}}{%
    \ifthenelse{\boolean{colourif}}{%
      \includepdf[picturecommand={%
        \put(820,580){\makebox(0,0)[tr]{\href{run:#2.png}{\scriptsize\mygreen{#2}}}}%
        \put(820,570){\makebox(0,0)[tr]{\scalebox{0.7}{\mygreen{#1}}}}}]{#2.png}}{%
      \includepdf[picturecommand={%
        \put(820,580){\makebox(0,0)[tr]{\href{run:#2_bw.png}{\scriptsize\mygreen{#2}}}}%
        \put(820,570){\makebox(0,0)[tr]{\scalebox{0.7}{\mygreen{#1}}}}}]{#2_bw.png}}}%
  \let\includegraphics\newIncludegraphics%
  \pagecolor{white}%
  \renewcommand{\thepage}{\arabic{chapter}-\arabic{page}}}
\newcommand{\pngpageHidden}[2][]{%
  \setboolean{pagehidden}{true}%
  \pngpage[#1]{#2}
  \setboolean{pagehidden}{false}}

\newcounter{xtrapage}
\setcounter{xtrapage}{0}
\newcommand{\xtrapage}{%
  \addtocounter{xtrapage}{1}
  \addtocounter{page}{-1}
  \renewcommand{\thepage}{+\arabic{xtrapage}}}
\newcommand{\normalpage}{%
  \renewcommand{\thepage}{\arabic{chapter}-\arabic{page}}}

\ifthenelse{\boolean{englishif}}{%
  \newcommand\lettergroupSymbNum[1]{
    \par\textbf{Symbols and Numbers}\par
    \nopagebreak
  }}{%
  \newcommand\lettergroupSymbNum[1]{
    \par\textbf{Symbole und Zahlen}\par
    \nopagebreak
  }}

\input{commands}

\input{localcommands}

% Abstand nach Komma im deutschen unterdrücken
\ifthenelse{\boolean{englishif}}{}{%
  % \mathcode`.="613A
  % \mathcode`,="013B
  % \RequirePackage{ziffer}
  \RequirePackage{icomma}
}

% zusätzliche Hoch- und Tiefstellungen für unicode-math, vgl. unicode-math-xetex.sty
\ExplSyntaxOn
% \prop_new:N \g_um_supers_propAdd
% \prop_new:N \g_um_subs_propAdd
% \group_begin:
% \cs_new:Nn \um_setup_active_superscriptAdd:nn {
% \prop_gput:Nxn \g_um_supers_propAdd   {\meaning #1} {#2}
% \char_set_catcode_active:N #1
% \char_gmake_mathactive:N #1
% \scantokens{
% \cs_gset:Npn #1 {
% \tl_set:Nn \l_um_ss_chain_tl {#2}
% \cs_set_eq:NN \um_sub_or_super:n \sp
% \tl_set:Nn \l_um_tmpa_tl {supers}
% \um_scan_sscriptAdd:
% }
% }
% }
%   super
\__um_setup_active_superscript:nn {"1D38} {L}
\__um_setup_active_superscript:nn {"1D39} {M}
\__um_setup_active_superscript:nn {"1D3A} {N}
\__um_setup_active_superscript:nn {"1D3F} {R}
\__um_setup_active_superscript:nn {"1D40} {T}
\__um_setup_active_superscript:nn {"1D43} {a}
\__um_setup_active_superscript:nn {"1D48} {d}
\__um_setup_active_superscript:nn {"1D49} {e}
\__um_setup_active_superscript:nn {"1D4D} {g}
\__um_setup_active_superscript:nn {"1D4F} {k}
\__um_setup_active_superscript:nn {"02E1} {l}
\__um_setup_active_superscript:nn {"1D50} {m}
\__um_setup_active_superscript:nn {"1D56} {p}
\__um_setup_active_superscript:nn {"2E3} {x}
\__um_setup_active_superscript:nn {"1D45} {α}
% 
% \cs_new:Nn \um_setup_active_subscriptAdd:nn {
% \prop_gput:Nxn \g_um_subs_propAdd   {\meaning #1} {#2}
% \char_set_catcode_active:N #1
% \char_gmake_mathactive:N #1
% \scantokens{
% \cs_gset:Npn #1 {
% \tl_set:Nn \l_um_ss_chain_tl {#2}
% \cs_set_eq:NN \um_sub_or_super:n \sb
% \tl_set:Nn \l_um_tmpa_tl {subs}
% \um_scan_sscriptAdd:
% }
% }
% }
%   sub
%   \__um_setup_active_subscript:nn {"209c} {t}
%   
%   \group_end:
%   \cs_new:Npn \um_scan_sscriptAdd: {
%   \um_scan_sscript:TF {
%   \um_scan_sscriptAdd:
% }{
%   \um_sub_or_super:n {\l_um_ss_chain_tl}
% }
% }
\ExplSyntaxOff

% ------
% % Automatischer Wechsel auf andere Schriftarten
% \newfontfamily\arabicxfont{Arial}
% \XeTeXinterchartokenstate=1
% \newXeTeXintercharclass\arabicx
% \ifthenelse{\boolean{dejavuif}}{}{%
%   % \XeTeXcharclass"627=\arabicx
%   % \XeTeXcharclass"62E=\arabicx
%   % \XeTeXcharclass"631=\arabicx
%   % \XeTeXcharclass"632=\arabicx
%   % \XeTeXcharclass"648=\arabicx
%   % \XeTeXcharclass"645=\arabicx
% \count255="627 % ا – ۿ
% \loop\ifnum\count255<"6FF
% \XeTeXcharclass\count255=\arabicx
% \advance\count255 by 1
% \repeat
% }
%   \XeTeXinterchartoks 0 \arabicx = {\begingroup\arabicxfont}
%   \XeTeXinterchartoks 255 \arabicx = {\begingroup\arabicxfont}
%   \XeTeXinterchartoks \arabicx 0 = {\endgroup}
%   \XeTeXinterchartoks \arabicx 255 = {\endgroup}

% %   \newfontfamily\chinesefont{M+ 1c regular}
%   \newfontfamily\chinesefont{WenQuanYi Micro Hei}
%   \XeTeXinterchartokenstate=1
%   \newXeTeXintercharclass\chinese
%   \XeTeXcharclass"3053=\chinese % こ
%   \XeTeXcharclass"3061=\chinese % ち
%   \XeTeXcharclass"306B=\chinese % に
%   \XeTeXcharclass"306F=\chinese % は
%   \XeTeXcharclass"3093=\chinese % ん
%   \XeTeXcharclass"30AB=\chinese % カ
%   \XeTeXcharclass"4E16=\chinese % 世
%   \XeTeXcharclass"4E2D=\chinese % 中
%   \XeTeXcharclass"4E4B=\chinese % 之
%   \XeTeXcharclass"4E8C=\chinese % 二
%   \XeTeXcharclass"4F60=\chinese % 你
%   \XeTeXcharclass"4FE1=\chinese % 信
%   \XeTeXcharclass"5149=\chinese % 光
%   \XeTeXcharclass"53A6=\chinese % 厦
%   \XeTeXcharclass"53CB=\chinese % 友
%   \XeTeXcharclass"53F7=\chinese % 号
%   \XeTeXcharclass"54C1=\chinese % 品
%   \XeTeXcharclass"56FD=\chinese % 国
%   \XeTeXcharclass"5927=\chinese % 大
%   \XeTeXcharclass"5929=\chinese % 天
%   \XeTeXcharclass"592A=\chinese % 太
%   \XeTeXcharclass"597D=\chinese % 好
%   \XeTeXcharclass"5A01=\chinese % 威
%   \XeTeXcharclass"5B66=\chinese % 学
%   \XeTeXcharclass"5BB6=\chinese % 家
%   \XeTeXcharclass"5C71=\chinese % 山
%   \XeTeXcharclass"5DDE=\chinese % 州
%   \XeTeXcharclass"5E02=\chinese % 市
%   \XeTeXcharclass"5E7F=\chinese % 广
%   \XeTeXcharclass"5EE3=\chinese % 廣
%   \XeTeXcharclass"5EFA=\chinese % 建
%   \XeTeXcharclass"5FC3=\chinese % 心
%   \XeTeXcharclass"606F=\chinese % 息
%   \XeTeXcharclass"6280=\chinese % 技
%   \XeTeXcharclass"6587=\chinese % 文
%   \XeTeXcharclass"65E0=\chinese % 无
%   \XeTeXcharclass"65E5=\chinese % 日
%   \XeTeXcharclass"65E9=\chinese % 早
%   \XeTeXcharclass"6668=\chinese % 晨
%   \XeTeXcharclass"666E=\chinese % 普
%   \XeTeXcharclass"672C=\chinese % 本
%   \XeTeXcharclass"672F=\chinese % 术
%   \XeTeXcharclass"6771=\chinese % 東
%   \XeTeXcharclass"680B=\chinese % 栋
%   \XeTeXcharclass"6881=\chinese % 梁
%   \XeTeXcharclass"6C49=\chinese % 汉
%   \XeTeXcharclass"6CB3=\chinese % 河
%   \XeTeXcharclass"6E56=\chinese % 湖
%   \XeTeXcharclass"79D1=\chinese % 科
%   \XeTeXcharclass"754C=\chinese % 界
%   \XeTeXcharclass"795E=\chinese % 神
%   \XeTeXcharclass"798F=\chinese % 福
%   \XeTeXcharclass"7B97=\chinese % 算
%   \XeTeXcharclass"7CB5=\chinese % 粵
%   \XeTeXcharclass"7EA7=\chinese % 级
%   \XeTeXcharclass"81FA=\chinese % 臺
%   \XeTeXcharclass"8A71=\chinese % 話
%   \XeTeXcharclass"8A9E=\chinese % 語
%   \XeTeXcharclass"8BA1=\chinese % 计
%   \XeTeXcharclass"8BDD=\chinese % 话
%   \XeTeXcharclass"8BED=\chinese % 语
%   \XeTeXcharclass"8D85=\chinese % 超
%   \XeTeXcharclass"901A=\chinese % 通
%   \XeTeXcharclass"9521=\chinese % 锡
%   \XeTeXcharclass"95E8=\chinese % 门
%   \XeTeXcharclass"9632=\chinese % 防
%   \XeTeXcharclass"9673=\chinese % 陳
%   \XeTeXcharclass"AE00=\chinese % 글
%   \XeTeXcharclass"AE4C=\chinese % 까
%   \XeTeXcharclass"B155=\chinese % 녕
%   \XeTeXcharclass"B2C8=\chinese % 니
%   \XeTeXcharclass"C138=\chinese % 세
%   \XeTeXcharclass"C2ED=\chinese % 십
%   \XeTeXcharclass"C548=\chinese % 안
%   \XeTeXcharclass"C694=\chinese % 요
%   \XeTeXcharclass"D558=\chinese % 하
%   \XeTeXcharclass"D55C=\chinese % 한
%   \XeTeXcharclass"FF7A=\chinese % ｺ
%   \XeTeXcharclass"FF81=\chinese % ﾁ
%   \XeTeXcharclass"FF86=\chinese % ﾆ
%   \XeTeXcharclass"FF8A=\chinese % ﾊ
%   \XeTeXcharclass"FF9D=\chinese % ﾝ
%   \XeTeXinterchartoks 0 \chinese = {\begingroup\chinesefont}
%   \XeTeXinterchartoks 255 \chinese = {\begingroup\chinesefont}
%   \XeTeXinterchartoks \chinese 0 = {\endgroup}
%   \XeTeXinterchartoks \chinese 255 = {\endgroup}

%   \newfontfamily\thaifont[Scale=0.8]{Droid Sans Thai}
%   \XeTeXinterchartokenstate=1
%   \newXeTeXintercharclass\thai
%   \XeTeXcharclass"E04=\thai % ค
%   \XeTeXcharclass"E14=\thai % ด
%   \XeTeXcharclass"E17=\thai % ท
%   \XeTeXcharclass"E1A=\thai % บ
%   \XeTeXcharclass"E20=\thai % ภ
%   \XeTeXcharclass"E22=\thai % ย
%   \XeTeXcharclass"E23=\thai % ร
%   \XeTeXcharclass"E27=\thai % ว
%   \XeTeXcharclass"E29=\thai % ษ
%   \XeTeXcharclass"E2A=\thai % ส
%   \XeTeXcharclass"E30=\thai % ะ
%   \XeTeXcharclass"E31=\thai % ั
%   \XeTeXcharclass"E32=\thai % า
%   \XeTeXcharclass"E35=\thai % ี
%   \XeTeXcharclass"E44=\thai % ไ
%   \XeTeXcharclass"E48=\thai % ่
%   \XeTeXinterchartoks 0 \thai = {\begingroup\thaifont}
%   \XeTeXinterchartoks 255 \thai = {\begingroup\thaifont}
%   \XeTeXinterchartoks \thai 0 = {\endgroup}
%   \XeTeXinterchartoks \thai 255 = {\endgroup}

%   \newfontfamily\indicfont{Lohit Devanagari}
%   \XeTeXinterchartokenstate=1
%   \newXeTeXintercharclass\indic
%   \XeTeXcharclass"902=\indic % ं
%   \XeTeXcharclass"915=\indic % क
%   \XeTeXcharclass"924=\indic % त
%   \XeTeXcharclass"926=\indic % द
%   \XeTeXcharclass"928=\indic % न
%   \XeTeXcharclass"92E=\indic % म
%   \XeTeXcharclass"930=\indic % र
%   \XeTeXcharclass"938=\indic % स
%   \XeTeXcharclass"939=\indic % ह
%   \XeTeXcharclass"93E=\indic % ा
%   \XeTeXcharclass"93F=\indic % ि
%   \XeTeXcharclass"940=\indic % ी
%   \XeTeXcharclass"947=\indic % े
%   \XeTeXcharclass"94D=\indic % ्
%   \XeTeXcharclass"964=\indic % ।
%   \XeTeXinterchartoks 0 \indic = {\begingroup\indicfont}
%   \XeTeXinterchartoks 255 \indic = {\begingroup\indicfont}
%   \XeTeXinterchartoks \indic 0 = {\endgroup}
%   \XeTeXinterchartoks \indic 255 = {\endgroup}

%   \newfontfamily\gothicfont{FreeSerif}
%   \XeTeXinterchartokenstate=1
%   \newXeTeXintercharclass\gothic
%   \XeTeXcharclass"10330=\gothic % 𐌰
%   \XeTeXinterchartoks 0 \gothic = {\begingroup\gothicfont}
%   \XeTeXinterchartoks 255 \gothic = {\begingroup\gothicfont}
%   \XeTeXinterchartoks \gothic 0 = {\endgroup}
%   \XeTeXinterchartoks \gothic 255 = {\endgroup}

%   \newcommand{\disablefontchange}{%
%   \XeTeXinterchartoks 0 \arabicx = {\begingroup}%
%   \XeTeXinterchartoks 255 \arabicx = {\begingroup}%
%   \XeTeXinterchartoks 0 \chinese = {\begingroup}%
%   \XeTeXinterchartoks 255 \chinese = {\begingroup}%
%   \XeTeXinterchartoks 0 \thai = {\begingroup}%
%   \XeTeXinterchartoks 255 \thai = {\begingroup}%
%   \XeTeXinterchartoks 0 \indic = {\begingroup}%
%   \XeTeXinterchartoks 255 \indic = {\begingroup}%
%   \XeTeXinterchartoks 0 \gothic = {\begingroup}%
%   \XeTeXinterchartoks 255 \gothic = {\begingroup}}
