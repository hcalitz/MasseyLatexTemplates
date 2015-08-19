%%
%% IFSCommunication class is a general IFS communications template.
%% It provides official looking templates for 
%% Memos
%% Letters
%% Minutes
%%
%% Author JJ Calitz May 2015
%% This file can be changed, although it would be nice to have a centrally maintained version
%% 
%% 	This file is under revision and should not considered to be final
%%
%%  CHANGES -----------------------------------------------------------------------
%   v0.2a 
%     added line for second sender of letters and memos (May 2015) JJCalitz
%     added default variable values (only specify what is needed)
%     option to display titles in signatures
%   v0.3a
%     added starred versions of senderFax, senderEmail and senderWww that can be excluded from footer (line 84-109)
%     added \letterto{} field (line 111)
%     change fonts to align with Massey Brand (helvet)
%%  CHANGES -----------------------------------------------------------------------

\typeout{IFSCommunication v0.3a}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IFSCommunication}[2015/05/01 v0.2a]

\usepackage[T1]{fontenc}
\usepackage[scaled]{helvet}
\renewcommand*\familydefault{\sfdefault}
\usepackage{xparse}

% Define variables used
\newif\if@sig 	% signature added?
\newlength\clf 	% length for letter 


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper]{article}

\advance\textheight by 25mm
\advance\topmargin by -12.5mm
\oddsidemargin 0mm
\textwidth 160mm
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{fancyvrb}
\RequirePackage{ifthen}
\RequirePackage{xspace}
\RequirePackage{currfile}
\RequirePackage{color}
\RequirePackage{suffix}

\newcommand*{\senderTitle}[1]{\def\IFStitle{#1~}}
\newcommand*{\senderName}[1]{\def\IFSname{#1\xspace}}
\newcommand*{\senderRole}[1]{%
\ifthenelse{\equal{#1}{}}
{\def\IFSrole{}}
{\def\IFSrole{,~#1\xspace}}
}
\newcommand*{\senderSuppTitle}[1]{\def\IFSsuptitle{#1~}}
\newcommand*{\senderSuppRole}[1]{%
\ifthenelse{\equal{#1}{}}
{\def\IFSsuprole{}}
{\def\IFSsuprole{,~#1\xspace}}
}
\newcommand*{\senderSuppName}[1]{%
\ifthenelse{\equal{#1}{}}
{\def\IFSletterfrom{\IFStitle\IFSname\IFSrole}
}{
\def\IFSsupname{#1\xspace}
\def\IFSletterfrom{\IFStitle\IFSname\IFSrole\\\IFSsuptitle\IFSsupname\IFSsuprole}}
}
\newcommand*{\senderDept}[1]{\def\IFSdept{#1\xspace}}
\newcommand*{\senderUnit}[1]{\def\IFSunit{#1\xspace}}
\newcommand*{\senderAddressOne}[1]{\def\IFSaddressOne{#1\xspace}}
\newcommand*{\senderAddressTwo}[1]{\def\IFSaddressTwo{#1\xspace}}
\newcommand*{\senderAddressThree}[1]{\def\IFSaddressThree{#1\xspace}}
\newcommand*{\senderAddressFour}[1]{\def\IFSaddressFour{#1\xspace}}
\newcommand*{\senderCountry}[1]{\def\IFScountry{#1\xspace}}
\newcommand*{\senderTelephone}[1]{\def\IFStelephone{#1\xspace}}
\newcommand*{\senderExtention}[1]{\def\IFSextention{#1\xspace}}

\newcommand\senderFax[1]{%
\def\IFSfax{#1\xspace}
\def\ShowFax{$\cdot$ Fax \IFSfax}
}
\WithSuffix\newcommand\senderFax*[1]{%
\def\IFSfax{#1\xspace}
\def\ShowFax{}
}

\newcommand\senderEmail[1]{
\def\IFSemail{#1\xspace}
\def\ShowEmail{ $\cdot$ Email~\,{\tt \IFSemail}}
}
\WithSuffix\newcommand\senderEmail*[1]{%
\def\IFSemail{#1\xspace}
\def\ShowEmail{}
}

\newcommand\senderWww[1]{
\def\IFSwww{#1\xspace}
\def\ShowWWW{ $\cdot$ \IFSwww}
}
\WithSuffix\newcommand\senderWww*[1]{%
\def\IFSwww{#1\xspace}
\def\ShowWWW{}
}

\newcommand*{\letterTo}[1]{\def\IFSletterto{#1}}


% Letter --------------------------------

\DeclareDocumentCommand{\signletter}{ O{sig1} O{sig2} m }{%
\ifthenelse{\equal{#3}{yes}}
{
\@sigtrue
\def\sigfilename{#1}
\def\sigsupfilename{#2}
}{
\@sigfalse
}
}

% Memo --------------------------------

\newcommand*{\memoFrom}[1]{
\ifthenelse{\equal{#1}{}}
{\def\IFSmemofrom{\IFSletterfrom}}
{\def\IFSmemofrom{#1\xspace}}
}
\newcommand*{\memoTo}[1]{\def\IFSmemoto{#1\xspace}}
\newcommand*{\memoCC}[1]{\def\IFSmemocc{#1\xspace}}
\newcommand*{\memoSubject}[1]{\def\IFSmemosubject{#1\xspace}}

% Minutes --------------------------------

\newcommand*{\meetingTime}[1]{\def\IFSmeettime{#1\xspace}}
\newcommand*{\meetingDate}[1]{\def\IFSmeetdate{#1\xspace}}
\newcommand*{\meetingPlace}[1]{\def\IFSmeetplace{#1\xspace}}
\newcommand*{\meetingGroup}[1]{\def\IFSmeetgroup{#1\xspace}}
\newcommand*{\meetingPresent}[1]{\def\IFSmeetpresent{#1\xspace}}
\newcommand*{\meetingAbsent}[1]{\def\IFSmeetabsent{#1\xspace}}
\newcommand*{\meetingAttendance}[1]{\def\IFSmeetattendance{#1\xspace}}

% Filenames on documents --------------------

% Save thefilename to a box for use later 

\newcommand{\addfilename}[2][]{%
\ifthenelse{\equal{#2}{yes}}
{
\def\filenamestring{\footnotesize #1\currfilepath}
}{
\def\filenamestring{}
}
}

\newcommand{\fullmonthname}{%
  \relax\ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December\fi}
\newcommand{\nztoday}{\number\day\space\fullmonthname\space\number\year}

%\address{}
%\telephone{+64 6 356 9099}
%\fax{+64 6 350 5682}
%\email{}
%\www{{}http://www.massey.ac.nz/}

%\if@consgroup%
%  \newcommand*{\groupname}[1]{\def\consgpname{#1}}
%  \newcommand*{\director}[1]{\def\consdirector{#1}}
%  \groupname{Massey University}
%  \director{}
%\fi
%
%\if@manager%
%  \newcommand*{\role}[1]{\def\mgrrole{#1}}
%  \role{}
%\fi

% Headers and footers (With line) ------------------------------------------------------

\newcommand{\ps@firstpage}{%
\renewcommand{\@oddhead}{%
\begin{picture}(250,10)(0,0)
\begin{minipage}{\textwidth}
{\null\hfill \filenamestring}\\

\centering{\resizebox{180pt}{!}{\includegraphics{masseyUniversityLogo}}}
\rule{\textwidth}{1pt}
\centering{{\small{\fontseries{bc}\selectfont \IFSunit}}}\\
%\centering{{\footnotesize{\it \IFStitle \IFSname \IFSrole}}}\\
%\centering{{\footnotesize{\it \IFSsupnames}}}
\centering{{\footnotesize{\it \IFSletterfrom}\\}}
\end{minipage}
\end{picture}
}

\renewcommand{\@oddfoot}{ %
\begin{minipage}{\textwidth}
\vspace{1pt}
\rule{\textwidth}{1pt}
\centering{{\footnotesize {\IFSunit $\cdot$ \IFSaddressOne $\cdot$ \IFSaddressTwo $\cdot$ \IFSaddressThree$\cdot$ \IFScountry}}}\\
\centering{{\footnotesize {Tel. \IFStelephone\IFSextention \ShowFax \ShowEmail \ShowWWW}}}
\end{minipage}
}
}

% Headers and footers (No line) ------------------------------------------------------

\newcommand{\ps@nolinefirstpage}{%
\renewcommand{\@oddhead}{%
\begin{picture}(250,10)(0,0)
\begin{minipage}{\textwidth}
{\null\hfill \filenamestring}\\

\centering{\resizebox{180pt}{!}{\includegraphics{masseyUniversityLogo}}}\\
%\rule{\textwidth}{1pt}
\centering{{\small{\fontseries{bc}\selectfont\IFSunit}}}\\
%\centering{{\footnotesize{\it \IFStitle\IFSname\IFSrole}}}\\
%\centering{{\footnotesize{\it \IFSsupnames}}}\\
\centering{{\footnotesize{\it \IFSletterfrom}\\}}
\end{minipage}
\end{picture}
}

\renewcommand{\@oddfoot}{ %
\begin{minipage}{\textwidth}
\vspace{1pt}
\rule{\textwidth}{1pt}
\centering{{\footnotesize {\IFSunit $\cdot$ \IFSaddressOne $\cdot$ \IFSaddressTwo $\cdot$ \IFSaddressThree$\cdot$ \IFScountry}}}\\
\centering{{\footnotesize {Tel. \IFStelephone\IFSextention \ShowFax \ShowEmail \ShowWWW}}}
\end{minipage}
}
}

% LETTER -----------------------------------------------------------------------------

\newcommand{\letter}[2][]{%

\settoheight\clf{\Huge #1}

%\topmargin=-0.5in
%\oddsidemargin=0in
%\evensidemargin=0in
%\textwidth=6.25in             % A4 paper is 8.25in wide
%\headheight=0pt
%\headsep=15pt
%\topmargin=-0.15in
%\textheight=9.5in              % A4 paper is 11.7in high

\parindent=0pt
\parskip=10pt 

\thispagestyle{firstpage}%
\null
\vspace*{3\baselineskip}

\hfill\begin{minipage}[b][\clf][t]{0.6\textwidth}
\flushright
\scalebox{1.2}{\color[rgb]{1.0,0.3,0.3}{\Huge {\sc #1}}}
\end{minipage}

\vspace*{2\baselineskip}
\begin{minipage}{0.4\textwidth}
\nztoday \\ 
{\raggedright \\ 
\IFSletterto
\par}%
\end{minipage}

\vspace{2\baselineskip}%
%\vfill
%#2\par
%\vfill
}

\newcommand{\opening}[1]{%
  \thispagestyle{firstpage}%
  \vspace*{40pt}%
  \nztoday \\ 
  {\raggedright \\ \par}%
  \vspace{2\parskip}%
  #1\par
  } % end opening

\newcommand{\closing}[2][]{%
  %\vspace{2\parskip}%
  \ifthenelse{\equal{\IFSletterfrom}{\IFStitle\IFSname\IFSrole}}
  { % Only one sender
  \begin{center}
  \parbox{0.3\textwidth}{\raggedright
       \ignorespaces #2%
        \if@sig
           \\ $ $ \\ \resizebox{100pt}{!}{\includegraphics{\sigfilename}} \\ $ $ \\
		   %\fromsig 
        \else 
           \vspace{20pt} %\\ \fromsig 
        \fi
        \ifthenelse{\equal{#1}{t}}
        {\IFStitle\IFSname}
        {\IFSname}
        }
   \end{center}
   \vfill
   \null  
  }{
  % Additional letter writer
  \vspace{2.5\parskip}%
  \hspace*{0.05\textwidth}\begin{minipage}{0.5\textwidth}
  \parbox{\textwidth}{\raggedright
       \ignorespaces #2%
        \if@sig
           \\ $ $ \\ \resizebox{100pt}{!}{\includegraphics{\sigfilename}} \\ $ $ \\
		   %\fromsig 
           \else \vspace{20pt} \\ %\\ \fromsig 
        \fi
        \ifthenelse{\equal{#1}{t}}
        {\IFStitle\IFSname}
        {\IFSname}
        }
   \end{minipage}
   \hspace*{0.05\textwidth}\begin{minipage}{0.5\textwidth}
   \parbox{\textwidth}{\raggedright
       \ignorespaces #2%
        \if@sig
           \\ $ $ \\ \resizebox{100pt}{!}{\includegraphics{\sigsupfilename}} \\ $ $ \\
		   %\fromsig 
        \else 
           \vspace{20pt} \\%\\ \fromsig 
        \fi
        \ifthenelse{\equal{#1}{t}}
        {\IFSsuptitle\IFSsupname}
        {\IFSsupname}
        }
   \end{minipage}   
   \vfill
   \null   
  }
   } % end closing

% Memorandum --------------------------------------------------------

\newcommand{\memo}[1][]{%
%\topmargin=-0.5in
%\oddsidemargin=0in
%\evensidemargin=0in
%\textwidth=6.25in             % A4 paper is 8.25in wide
%\headheight=0pt
%\headsep=5pt
%\topmargin=-0.15in
%\textheight=9.5in              % A4 paper is 11.7in high

\parindent=0pt
\parskip=10pt 

\thispagestyle{nolinefirstpage}%
\null
\vspace*{2\baselineskip}
%\begin{minipage}{\textwidth}
%{\null\hfill \filenamestring}\\
%
%\centering{\resizebox{180pt}{!}{\includegraphics{masseyUniversityLogo}}}\\
%\vspace*{2ex}
%\centering{{\small{\sc \IFSunit}}}\\
%\centering{{\footnotesize{\it \IFStitle\IFSname\IFSrole }}} $ $
%\end{minipage}

{\Large{\sc Memorandum}}
\hfill
\scalebox{1.2}{\color[rgb]{1.0,0.3,0.3}{\Huge {\sc #1}}}
\\
\rule{\textwidth}{2pt}

\begin{tabular}{lp{0.8\textwidth}}
{\bf To:}   & \IFSmemoto\\
{\bf From:} & \begin{minipage}[t]{\textwidth}
\IFSmemofrom
\end{minipage}\\
{\bf CC:}   & \IFSmemocc\\
{\bf Date:} & \nztoday\\
{\bf Subject:} & 
\end{tabular}

\rule{\textwidth}{1pt}
}

% Meeting Minutes -------------------------------------------

\newcommand{\meeting}{%
%\topmargin=-0.5in
%\oddsidemargin=0in
%\evensidemargin=0in
%\textwidth=6.25in             % A4 paper is 8.25in wide
%\headheight=20pt
%\headsep=25pt
%\topmargin=-0.5in
%\textheight=9.5in              % A4 paper is 11.7in high

\parindent=0pt
\parskip=10pt 
\thispagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}  %get rid of header

\rhead{\filenamestring}


\begin{center}
\large \textbf{Meeting of the \IFSmeetgroup \\held at \IFSmeettime in \IFSmeetplace on \IFSmeetdate}

{\Large \sc \textbf{MINUTES}}

\fbox{\begin{minipage}{0.8\textwidth}
\centering 
These minutes are provisional until their accuracy or otherwise is confirmed at a subsequent meeting of this Committee.
\end{minipage}
}
\end{center}

\begin{tabular}{p{0.2\textwidth}p{0.8\textwidth}}
{\bf Present:}   & \IFSmeetpresent\\ &\\
{\bf Absent:} & \IFSmeetabsent\\&\\
{\bf In Attendance:}   & \IFSmeetattendance\\&\\
\end{tabular}
} % end meeting minutes


% Define all variables

\senderTitle{}
\senderName{}
\senderRole{}
\senderSuppTitle{}
\senderSuppName{}
\senderSuppRole{}
\senderDept{}
\senderUnit{Institute of Fundamental Sciences}
\senderAddressOne{Massey University}
\senderAddressTwo{Private Bag 11222}
\senderAddressThree{Palmerston North}
\senderCountry{New Zealand}
\senderTelephone{+64 6 }
\senderExtention{}
\senderFax*{+64 6 }
\senderEmail{}
\senderWww{http://www.massey.ac.nz/}
\signletter{no}  
\letterTo{}
\memoTo{}
\memoFrom{}
\memoCC{}
\memoSubject{}
\meetingDate{}
\meetingTime{}
\meetingPlace{}
\meetingGroup{}
\meetingPresent{}
\meetingAbsent{}
\meetingAttendance{}
\addfilename{no} 

\endinput