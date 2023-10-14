#!/usr/bin/perl -w

use Env qw(HOME);
use lib "$HOME/LehreAllgemein/VorlesungsTemplate/Tools/src/syhl";
use charnames ':full';
use utf8;
do "syhlfun.pl";

$outCol = "\033[38;2;0;0;180m";

## use stdin and stdout by default
$inputFileName = "-";
$outputFileName = "-";

## check command line parameters
$srcdir = "";
foreach (@ARGV)
{
    if (/^([^\-].*)\.twl/)
    {
        $inputFileName = $_;
        $outputFileName = $1 . ".tex";
    }
    elsif (/^[^\-].*/)
    {
        $inputFileName = $_ . ".twl";
        $outputFileName = $_ . ".tex";
    }
    elsif (/^-srcdir=(.*)$/)
    {
        $srcdir = $1;
    }
}

## read input file
open(INPUTFILE, "<$inputFileName") ||
    die "Could not open $inputFileName for reading";
$inputText = "";
while ($line = <INPUTFILE>)
{
    $inputText .= $line;
}
close(INPUTFILE);

## convert listings
$numInline = $numEnv = $numExt = 0;
$outputText = $inputText;
$numInline += int $outputText =~ s/\\([a-zA-Z_0-9@]+)Inline(\x{c2}\x{a7})(.+?)(\2)/callSyhlInline($1, $3)/eg;
$numInline += int $outputText =~ s/\\([a-zA-Z_0-9@]+)Inline(.)(.+?)(\2)/callSyhlInline($1, $3)/eg;
$numEnv = int $outputText =~ s/\\begin\{([a-zA-Z_0-9@]+)ListInline\}\s*\n(.+?)\s*\\end\{\1ListInline\}/callSyhlEnv($1, $2, 0)/egs;
$numEnv += int $outputText =~ s/\\begin\{([a-zA-Z_0-9@]+)ListInlineSmall\}\s*\n(.+?)\s*\\end\{\1ListInlineSmall\}/callSyhlEnv($1, $2, 1)/egs;
$numEnv += int $outputText =~ s/\\begin\{([a-zA-Z_0-9@]+)ListInlineSmaller\}\s*\n(.+?)\s*\\end\{\1ListInlineSmaller\}/callSyhlEnv($1, $2, 2)/egs;
$numEnv += int $outputText =~ s/\\begin\{([a-zA-Z_0-9@]+)ListInlineSesqui\}\s*\n(.+?)\s*\\end\{\1ListInlineSesqui\}/callSyhlEnv($1, $2, 1.5)/egs;
$numEnv += int $outputText =~ s/\\begin\{([a-zA-Z_0-9@]+)ListInlineList2Pr\}\s*\n(.+?)\s*\\end\{\1ListInlineList2Pr\}/callSyhlEnv($1, $2, -1)/egs;
$numExt += int $outputText =~ s/\\([a-zA-Z_0-9@]+)List\{(.+?)\}/callSyhlList($1, $2)/eg;

## math colours (experimental)
#$outputText =~ s/([^\\])\\\[(.+?)\\\]/$1\\[\\begingroup\\mathcol $2\\endgroup\\]/gs;
#$outputText =~ s/\\begin\{align\*\}(.+?)\\end\{align\*\}(\s*)/\\colorlet\{oldcol\}\{\.\}\\mathcol\\begin\{align\*\}$1\\end\{align\*\}$2\\color\{oldcol\}/gs;

## write output file
open(OUTPUTFILE, ">$outputFileName") ||
    die "Could not open $outputFileName for writing";
print OUTPUTFILE $outputText;
close(OUTPUTFILE);

print "$outCol $numInline $numEnv $numExt (xxInline, xxListInline, ",
    "xxList)\n" if $numInline + $numEnv > 0;

## end of main program
##############################################################

sub callSyhlInline
{
    my ($lang, $text) = @_;
    if ($lang eq "syhl")
    { return '\syhlInline{\stdbasicstyle\color{'; }
    $text = syhlfun($lang, "tex-inline", 0, 1, "", "-", $text);
    chomp($text);
    $text = '\syhlInline{' . $text . '}';
    if ($lang eq "Alg")
    {
        $text = "\\scalebox{0.75}[1]{" . $text . "}";
    }
    return $text;
}

sub callSyhlEnv
{
    my ($lang, $text, $size) = @_;
    if ($size == 0)
    { $text = syhlfun($lang, "tex", 0, 1, "", "-", $text); }
    elsif ($size == 1)
    { $text = syhlfun($lang, "tex-small", 0, 1, "", "-", $text); }
    elsif ($size == 2)
    { $text = syhlfun($lang, "tex-smaller", 0, 1, "", "-", $text); }
    elsif ($size == 1.5)
    { $text = syhlfun($lang, "tex-sesquismall", 0, 1, "", "-", $text); }
    elsif ($size == -1)
    { $text = syhlfun($lang, "tex-list2pr", 0, 1, "", "-", $text); }
    chomp($text);
    $text = "\\begin{syhlListInline}" . "\n" . $text
        . "\n\\end{syhlListInline}";
    return $text;
}

sub callSyhlList
{
    my ($lang, $filename) = @_;

    $langinfofilename = "$srcdir/$filename.langinfo";
    if (open(LANGINFOFILE, "<$langinfofilename"))
    {
        $oldlanginfo = <LANGINFOFILE>;
        close(LANGINFOFILE);
    }
    else
    { $oldlanginfo = ""; }
    if ($oldlanginfo ne $lang)
    {
        open(LANGINFOFILE, ">$langinfofilename") ||
            die "Could not open $langinfofilename for writing";
        print LANGINFOFILE $lang;
        close(LANGINFOFILE);
    }

    return "\\syhlList{$filename}";
}
