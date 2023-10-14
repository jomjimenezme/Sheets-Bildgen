#!/usr/bin/perl -w

$tmpfile = "list2pr_tmp";
if (defined($ARGV[0]) && $ARGV[0] eq "-v")
{
    shift @ARGV;
    $errout = "/dev/stderr";
}
else
{ $errout = "/dev/null"; }

if (defined($ARGV[0]) && $ARGV[0] eq "-c")
{
    shift @ARGV;
    $usecolours = 1;
}
else
{ $usecolours = 0; }

if (defined($ARGV[0]) && $ARGV[0] eq "-pdf")
{
    shift;
    $output = "pdf";
}
elsif (defined($ARGV[0]) && $ARGV[0] eq "-ps")
{
    shift;
    $output = "ps";
}
elsif (defined($ARGV[0]) && $ARGV[0] eq "-ps2")
{
    shift;
    $output = "ps2";
}
elsif (defined($ARGV[0]) && $ARGV[0] eq "-ps4")
{
    shift;
    $output = "ps4";
}
else
{
    print STDERR "usage: list2pr [-v] [-c] -pdf | -ps | -ps2 | -ps4 filelist\n";
    print STDERR "-pdf  : PDF-Output\n";
    print STDERR "-ps   : PostScript-Output\n";
    print STDERR "-ps2  : PS-Output sent through psnup -2\n";
    print STDERR "-ps4  : PS-Output sent through psnup -4\n";
    exit;
}

open(TMPFILE, ">$tmpfile.twl") || die "could not open $tmpfile";
print TMPFILE "\\documentclass[paper=a4,11pt,pagesize,headsepline]{scrartcl}\n";
print TMPFILE "\\usepackage{etex}\n";
print TMPFILE "\\usepackage{amsmath}\n";
print TMPFILE "\\usepackage{mathspec}\n";
print TMPFILE "\\usepackage{xltxtra}\n";
print TMPFILE "\\usepackage[babelshorthands]{polyglossia}\n";
print TMPFILE "\\usepackage{ifthen}\n";
print TMPFILE "\\newboolean{colourif}\n";
if ($usecolours)
{ print TMPFILE "\\setboolean{colourif}{true}\n"; }
else
{ print TMPFILE "\\setboolean{colourif}{false}\n"; }
print TMPFILE "\\newboolean{blanksif}\n";
print TMPFILE "\\setboolean{blanksif}{false}\n";
print TMPFILE "\\usepackage{scrlayer-scrpage}\n";
print TMPFILE "\\usepackage{color}\n";
print TMPFILE "\\usepackage{graphicx}\n";
print TMPFILE "\\usepackage{adjustbox}\n";
print TMPFILE "\\usepackage{pdfpages}\n";
print TMPFILE "\\input{mycolours}\n";
print TMPFILE "\\usepackage{collistings}\n";
print TMPFILE "\\setmainlanguage{german}\n";
print TMPFILE "\\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}\n";
print TMPFILE "\\setsansfont[Scale=1.4]{Arial Unicode MS}\n";
#print TMPFILE "\\setsansfont{FreeSans}\n";
print TMPFILE "\\setmonofont[Scale=0.9]{DejaVu Sans Mono}\n";
#print TMPFILE "\\setmonofont{TeX Gyre Cursor}\n";
print TMPFILE "\\setmainfont{FreeSerif}\n";
#print TMPFILE "\\addtokomafont{sectioning}{\\bfseries}\n";
print TMPFILE "\\typearea{25}\n";
print TMPFILE "\\pagestyle{scrheadings}\n";
@userinfo = getpwnam(getlogin());
$username = $userinfo[6];
print TMPFILE "\\clearscrheadfoot\n";
print TMPFILE "\\ihead{printed on ",
    `LANG=en_GB.UTF-8 date '+%A, %Y-%m-%d, %H:%M:%S'`, " by $username}\n";
print TMPFILE "\\ohead{\\pagemark}\n";

print TMPFILE "\\RequirePackage[CJK,Devanagari,Gothic,GeneralPunctuation,NumberForms,Thai,TransportAndMapSymbols]{ucharclasses}";
print TMPFILE "\\newfontfamily{\\thaifont}[Scale=0.8]{Droid Sans Thai}";
print TMPFILE "\\setTransitionsFor{Thai}{\\begingroup\\thaifont}{\\endgroup}";
print TMPFILE "\\newfontfamily{\\chinesefont}{WenQuanYi Micro Hei}";
print TMPFILE "\\setTransitionsForCJK{\\begingroup\\chinesefont}{\\endgroup}";
print TMPFILE "\\newfontfamily\\indicfont{Lohit Devanagari}";
print TMPFILE "\\setTransitionsFor{Devanagari}{\\begingroup\\indicfont}{\\endgroup}";
print TMPFILE "\\newfontfamily\\gothicfont{FreeSerif}";
print TMPFILE "\\setTransitionsFor{Gothic}{\\begingroup\\gothicfont}{\\endgroup}";
print TMPFILE "\\newfontfamily\\emojifont{Twitter Color Emoji}";
print TMPFILE "\\setTransitionsFor{TransportAndMapSymbols}{\\begingroup\\emojifont}{\\endgroup}";
print TMPFILE "\\newfontfamily\\genpunctfont{DejaVu Serif}";
#print TMPFILE "\\setTransitionsFor{GeneralPunctuation}{\\begingroup\\genpunctfont}{\\endgroup}";
#print TMPFILE "\\setTransitionsFor{NumberForms}{\\begingroup\\genpunctfont}{\\endgroup}";
print TMPFILE "\\newcommand{\\disablefontchange}{\\uccoff}";

print TMPFILE "\\begin{document}\n";

if ($output eq "ps4")
{ $lstcmd = "ListInline"; }
else
{ $lstcmd = "ListInlineList2Pr"; }
#{ $lstcmd = "ListInlineSmall"; }
#{ $lstcmd = "ListInlineSesqui"; }

foreach $file (@ARGV)
{
    if (-r $file)
    {
        $filetex = $file;
        $filetex =~ s/_/\\_/g;
        if (-d $file)
        { print STDERR "$file is a directory.\n"; }
        elsif (-z $file)
        {
            print STDERR "Processing $file (empty) ...\n";
            print TMPFILE "\\section*{\\disablefontchange $filetex}\n";
            print TMPFILE "File is empty\n";
        }
        elsif (`file -b -i -L "$file" | grep charset=binary` || $file =~ /\.pdf$/)
        {
            print STDERR "Processing $file (binary) ...\n";
            if ($file =~ /\.(png|jpg|jpeg|JPG)$/)
            {
                print TMPFILE "\\section*{\\disablefontchange $filetex}\n";
                print TMPFILE "\\maxsizebox{150mm}{250mm}{\\includegraphics{$file}}\n";
            }
            elsif ($file =~ /\.(pgm|ppm)$/)
            {
                $tmpfilepic = $tmpfile . "_pic_"
                    . `echo -n $file | sed 's,/,_,g'` . '.png';
                `convert $file $tmpfilepic`;
                print TMPFILE "\\section*{\\disablefontchange $filetex}\n";
                print TMPFILE "\\maxsizebox{150mm}{250mm}{\\includegraphics{$tmpfilepic}}\n";
            }
            elsif ($file =~ /\.pdf$/)
            {
                if (`pdfinfo "$file" | grep -a "Page size" | grep A4` ||
                    `pdfinfo "$file" | grep -a "Page size" | grep "594.75 x 842.25 pts"` ||
                    `pdfinfo "$file" | grep -a "Page size" | grep "595 x 841 pts"` ||
                    `pdfinfo "$file" | grep -a "Page size" | grep "612 x 792 pts"` ||
                    `pdfinfo "$file" | grep -a "Page size" | grep "611.28 x 789.57 pts"`)
                {
                    print TMPFILE "\\includepdf[pages=1,frame,templatesize={210mm}{230mm},pagecommand={\\section*{\\disablefontchange $filetex}}]{$file}\n";
                    `pdfinfo "$file" | grep -a Pages:` =~ /Pages:\s*(\d+)/;
                    $pages = $1;
                    if ($pages > 1)
                    { print TMPFILE "\\includepdf[pages=2-,frame,templatesize={210mm}{230mm},pagecommand={}]{$file}\n"; }
                }
                else
                {
                    print TMPFILE "\\section*{\\disablefontchange $filetex}\n";
                    print TMPFILE "\\maxsizebox{150mm}{250mm}{\\includegraphics{$file}}\n"
                }
            }
            elsif ($file =~ /\.(tgz|tar.gz)$/)
            {
                print TMPFILE "\\section*{\\disablefontchange $filetex}\n";
                print TMPFILE "\\begin{NoLangListInline$lstcmd}\n";
                open(TARCMD, "tar tfvz $file |");
                @taroutput = <TARCMD>;
                print TMPFILE @taroutput;
                close(TARCMD);
                print TMPFILE "\\end{NoLangListInline$lstcmd}\n";
            }
            else
            {
                print TMPFILE "\\section*{\\disablefontchange $filetex}\n";
                print TMPFILE "Unsupported file format\n";
                print STDERR "UNSUPPORTED FILE FORMAT\n";
            }
        }
        elsif ($file =~ /\.ps$/)
        {
            print STDERR "Processing $file ...\n";
            $tmpfilepdf = $tmpfile . "_pdf_" . `echo -n $file | sed 's,/,_,g'`;
            $tmpfilepdf =~ s/\.ps$/.pdf/;
            `ps2pdf14 -sPAPERSIZE=a4 -dPDFSETTINGS=/prepress -dSubsetFonts=true -dEmbedAllFonts=true -dAutoRotatePages=/All "$file" "$tmpfilepdf"`;
            print TMPFILE "\\includepdf[pages=1,frame,templatesize={210mm}{230mm},pagecommand={\\section*{\\disablefontchange $filetex}}]{./$tmpfilepdf}\n";
            `pdfinfo "$tmpfilepdf" | grep Pages:` =~ /Pages:\s*(\d+)/;
            $pages = $1;
            if ($pages > 1)
            { print TMPFILE "\\includepdf[pages=2-,frame,templatesize={210mm}{230mm},pagecommand={}]{$tmpfilepdf}\n"; }
        }
        else
        {
            print STDERR "Processing $file ...\n";
            print TMPFILE "\\section*{\\disablefontchange $filetex}\n";

            $langabbr = "NoLang";
            $langabbr = "Make" if ($file =~ /(Makefile|make)/);
            $langabbr = "C" if ($file =~ /\.c$/);
            $langabbr = "CC" if ($file =~ /\.(cc|cpp|cxx|h|C)$/);
            $langabbr = "Java" if ($file =~ /\.java$/);
            $langabbr = "CS" if ($file =~ /\.cs$/);
            $langabbr = "D" if ($file =~ /\.d$/);
            $langabbr = "F" if ($file =~ /\.(f|F)$/);
            $langabbr = "F90" if ($file =~ /\.(f90|f95)$/);
            $langabbr = "Pascal" if ($file =~ /\.(p|P|pas|PAS)$/);
            $langabbr = "Basic" if ($file =~ /\.vb$/);
            $langabbr = "Perl" if ($file =~ /\.(pl|pm)$/);
            $langabbr = "Py" if ($file =~ /\.py$/);
            $langabbr = "SH" if ($file =~ /\.sh$/);
            $langabbr = "Octave" if ($file =~ /\.m$/);
            $langabbr = "Lisp" if ($file =~ /\.(el|lisp)$/);
            $langabbr = "AutoConf" if ($file =~ /\.(ac|scan)$/);
            $langabbr = "SQL" if ($file =~ /\.sql$/);
            $langabbr = "HTML" if ($file =~ /\.(html|htm)$/);
            $langabbr = "XML" if ($file =~ /\.(xml|qrc)$/);
            $langabbr = "Latex" if ($file =~ /\.(tex|sty|fd|eepic|pictex)$/);
            $langabbr = "Mathematica" if ($file =~ /\.ma$/);
            $langabbr = "Test" if ($file =~ /\.test$/);
            $langabbr = "SH"
                if ($langabbr eq "NoLang" && `file -b -i -L "$file" | grep shell`);
            $langabbr = "Prolog"
                if ($langabbr eq "Perl" && `file -b -i -L "$file" | grep plain`);

            print TMPFILE "\\begin{${langabbr}$lstcmd}\n";
            if (`file -b -i -L "$file" | grep iso-8859-1`)
            {
                open(FILE, "recode -f l1..u8 < $file|");
            }
            else
            {
                open(FILE, "<$file");
            }
            print TMPFILE <FILE>;
            close(FILE);
            print TMPFILE "\\end{${langabbr}$lstcmd}\n";
            print TMPFILE "\n";
        }
    }
    else
    { print STDERR "File $file does not exist.\n"; }
}

print TMPFILE "\\end{document}\n";
close(TMPFILE);

print STDERR "Running twl2tex ...\n";
print `twl2tex -srcdir=. $tmpfile > /dev/null`;
`mv $tmpfile.tex $tmpfile.2.tex`;
`sed 's/\\\\\\\\%%%//' $tmpfile.2.tex > $tmpfile.tex`;
print STDERR "Running xeLaTeX ...\n";
#$ENV{TEXINPUTS} =
#    "$ENV{HOME}/LehreAllgemein/VorlesungsTemplate/:$ENV{TEXINPUTS}";
$ENV{TEXINPUTS} = "$ENV{HOME}/LehreAllgemein/VorlesungsTemplate/:";
if ($output eq "pdf")
{
    print `xelatex $tmpfile > $errout && \
        cat $tmpfile.pdf`;
}
elsif ($output eq "ps")
{
    print `xelatex $tmpfile > $errout && \
        pdftops -level2 -paper A4 -noshrink -nocenter -r 1200 $tmpfile.pdf $tmpfile.ps > /dev/null && \
        printf "%i pages\n" \`head -20 $tmpfile.ps | grep Pages | cut -d ' ' -f 2\` > /dev/stderr &&
        printf "%i bytes\n" \`ls -l $tmpfile.ps | cut -d ' ' -f 5\` > /dev/stderr && \
        cat $tmpfile.ps`;
}
elsif ($output eq "ps2")
{
    print `xelatex $tmpfile > $errout && \
        pdfjam -q --nup 2x1 --landscape --frame true --outfile $tmpfile.2up.pdf $tmpfile.pdf && \
        pdftops -level2 -paper A4 -noshrink -nocenter -r 1200 $tmpfile.2up.pdf $tmpfile.2up.ps > /dev/null && \
        printf "%i pages\n" \`head -20 $tmpfile.2up.ps | grep Pages | cut -d ' ' -f 2\` > /dev/stderr &&
        printf "%i bytes\n" \`ls -l $tmpfile.2up.ps | cut -d ' ' -f 5\` > /dev/stderr && \
        cat $tmpfile.2up.ps`;
}
#{ print `xelatex $tmpfile > $errout && pdftops -level2 -paper A4 -noshrink -nocenter -r 1200 $tmpfile.pdf $tmpfile.ps > /dev/null && psnup -pa4 -2 $tmpfile.ps`; }
elsif ($output eq "ps4")
{
    print `xelatex $tmpfile > $errout && \
        pdfjam -q --nup 2x2 --frame true --outfile $tmpfile.4up.pdf $tmpfile.pdf && \
        pdftops -level2 -paper A4 -noshrink -nocenter -r 1200 $tmpfile.4up.pdf $tmpfile.4up.ps > /dev/null && \
        printf "%i pages\n" \`head -20 $tmpfile.4up.ps | grep Pages | cut -d ' ' -f 2\` > /dev/stderr &&
        printf "%i bytes\n" \`ls -l $tmpfile.4up.ps | cut -d ' ' -f 5\` > /dev/stderr && \
        cat $tmpfile.4up.ps`;
}
#{ print `xelatex $tmpfile > $errout && pdftops -level2 -paper A4 -noshrink -nocenter -r 1200 $tmpfile.pdf $tmpfile.ps > /dev/null && psnup -pa4 -4 $tmpfile.ps`; }
`rm -f $tmpfile*`;
