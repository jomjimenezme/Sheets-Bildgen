#!/usr/bin/perl -w

use Env qw(HOME);
use lib "$HOME/LehreAllgemein/VorlesungsTemplate/Tools/src/syhl";
do "syhlfun.pl";

$inputFileName = "-";
$outputFileName = "-";
$lstMark = "//LST";
$outCol = "\033[38;2;0;0;180m";

## check command line parameters
foreach (@ARGV)
{
    if (/^-lang=(.+)/)
    {
        $langAbbrev = $1;
        $lstMark = setLstMark($langAbbrev);
    }
    elsif (/^[^\-].*/)
    {
        $inputFileName = $_ . ".lst";
        $srcFileName = $_;
    }
}

## read input file
open(INPUTFILE, "<$inputFileName") ||
    die "Could not open $inputFileName for reading";
@inputText = <INPUTFILE>;
close(INPUTFILE);

## process input lines
$srcLineNum = 0;
%writing = ();
%outName = ();
%begLine = ();
%frameTB = ();
%lstText = ();
%fmtText = ();
%hiding = ();
$xlstMark = $lstMark;
$xlstMark =~ s/LST/XLST/;
foreach $line (@inputText)
{
    if ($line =~ /^\s*$lstMark(.+?)\s*$/)
    {
        $lstChars = $1;
        if ($lstChars =~ /^<(t|n|-)(b|n|-)(\d|q|-)(\d|\+|-)<(.+)$/)
        {
            $top = $1;
            $bot = $2;
            $size = $3;
            $skip = $4;
            $key = $5;
            $fsize{$key} = $size;
            $fsize{$key} = 0 if $size eq "-";
            $writing{$key} = 1;
            $begLine{$key} = $srcLineNum + 1;
            $frameTB{$key} = $top . "lr" . $bot;
            if ("$top$bot" eq "nn")
            { $frameTB{$key} = "----"; }
            $outName{$key} = $srcFileName . '.' . $key . '.tex';
            $lstText{$key} = "";
            $hiding{$key} = 0;
            if ($top eq "t")
            {
                ($title) = $srcFileName =~ /.+?\/(.+)/;
                $title =~ s/_/\\_/g;
                $title = "stdin" if !defined($title);
                $fmtText{$key} .= "\n{\\hfill\\ttfamily\\bfseries\\href{$srcFileName}{$title}\\hfill}\\vspace*{0mm}\\\\[-9mm]%";
            }
            elsif (!defined($fmtText{$key}))
            {
                $fmtText{$key} .= "\n\\vspace*{-5mm}";
            }
            elsif ($skip eq "+")
            {
                $fmtText{$key} .= "\n\\vspace*{2mm}%";
            }
            else
            {
                $fmtText{$key} .= "\n\\vspace*{1mm}%";
            }
            $fmtText{$key} .=
                "\n%%start: <$1$2$3$4<$key, line = $begLine{$key}\n";
            print "${outCol}[$key] ";
        }
        elsif ($lstChars =~ /^>(.+)$/)
        {
            $key = $1;
            $writing{$key} = 0;
            $fmtText{$key} .= callSyhlEnv($langAbbrev, $lstText{$key},
                                          $fsize{$key}, $begLine{$key},
                                          $frameTB{$key});
        }
        elsif ($lstChars =~ /=(.+?)=(.+)$/)
        {
            $key = $1;
            $label = $2;
            $labelLine = $srcLineNum - 1;
            $fmtText{$key} .= "\\setcounter{SyhlLineNo}{$labelLine}%\n";
            $fmtText{$key} .= "\\refstepcounter{SyhlLineNo}%\n";
            $fmtText{$key} .= "\\label{$label}%\n";
        }
        elsif ($lstChars =~ /-hideon-(.+)$/)
        {
            $key = $1;
            $hiding{$key} = 1;
        }
        elsif ($lstChars =~ /-hideoff-(.+)$/)
        {
            $key = $1;
            $hiding{$key} = 0;
        }
        else
        { die "wrong mark: $lstChars"; }
    }
    elsif ($line =~ /^\s*$xlstMark(.+?)\s*$/)
    {} # XLST is used to comment out LST marks
    else
    {
        $srcLineNum++;
        foreach $k (keys %writing)
        {
            if ($writing{$k})
            {
                if (!$hiding{$k})
                {
                    $lstText{$k} .= $line;
                }
                else
                {
                    chomp $line;
                    $lstText{$k} .= $line . "같HIDING같\n";
                }
            }
        }
    }
}

## write output files
$isUTF8 = `file -b -i $inputFileName | grep utf-8`;
$isUTF8 = `file -b -i $inputFileName | grep us-ascii` if !$isUTF8;
foreach $k (keys %writing)
{
    open(OUTPUTFILE, ">$outName{$k}") ||
        die "Could not open $outputFileName for writing";
    if ($isUTF8 || $langAbbrev =~ /(tex|Tex|TeX|latex|Latex|LaTeX)/)
    {
        print OUTPUTFILE "\\begin{syhlListExtern}%";
    }
    else
    {
        print OUTPUTFILE "\\begin{syhlListExternLatin}%";
    }
    print OUTPUTFILE $fmtText{$k};
    if ($isUTF8 || $langAbbrev =~ /(tex|Tex|TeX|latex|Latex|LaTeX)/)
    {
        print OUTPUTFILE "\n\\end{syhlListExtern}%";
    }
    else
    {
        print OUTPUTFILE "\n\\end{syhlListExternLatin}%";
    }
    close(OUTPUTFILE);
}
print "\n" if scalar keys %writing > 0;


## end of main program
##############################################################

sub setLstMark
{
    my $opt = $_[0];

    $lstMark = "//LST" if ($opt =~ /(slash|c|C|cc|CC|cpp|cxx|java|Java|d|D|cs|CS)/);
    $lstMark = "%%LST" if ($opt =~ /(percent|prolog|Prolog|pro|matlab|Matlab|tex|TeX|Tex|latex|Latex|LaTeX)/);
    $lstMark = ";;LST" if ($opt =~ /(semic|lisp|Lisp)/);
    $lstMark = "\\#\\#LST"
        if ($opt =~ /(hash|make|Make|octave|Octave|bash|sh|SH|perl|Perl|autoconf|AutoConf|html|HTML|jsp|xml|XML|mathematica|Mathematica|pascal|Pascal|python|Python|py|Py)/);
    $lstMark = "//LST" if ($opt =~ /(javash|JavaSH|qml|QML)/);
    $lstMark = "\\*\\*LST" if ($opt =~ /(star|f77|F)/);
    $lstMark = "!!LST" if ($opt =~ /(excl|f90|F90|f95|F95)/);
    $lstMark = "--LST" if ($opt =~ /(dash|sql|SQL)/);
    $lstMark = "''LST" if ($opt =~ /(apostr|basic|Basic|BASIC|vb|VB)/);
    $lstMark = "\\?\\?LST" if ($opt =~ /(nolang|NoLang)/);

    return $lstMark;
}

sub callSyhlEnv
{
    my ($lang, $text, $size, $begLine, $frame) = @_;
    $linenums = $frame ne "----";
    if ($size eq 0)
    { $text = syhlfun($lang, "tex", $linenums, $begLine, $frame, "-", $text); }
    elsif ($size eq 1)
    {
        $text = syhlfun($lang, "tex-small", $linenums, $begLine, $frame, "-",
                        $text);
    }
    elsif ($size eq 2)
    {
        $text = syhlfun($lang, "tex-smaller", $linenums, $begLine, $frame, "-",
                        $text);
    }
    elsif ($size eq 'q')
    {
        $text = syhlfun($lang, "tex-sesquismall", $linenums, $begLine, $frame,
                        "-", $text);
    }
    chomp($text);

    $text =~ s/^(.+)같HIDING같/\\begin{Hide}$1\\end{Hide}/gm;

    return $text;
}
