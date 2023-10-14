#!/usr/bin/perl -w

$inputFileName = "-";
$outputFileName = "-";
$lstMark = "//LST";

## check command line parameters
foreach (@ARGV)
{
    if (/^-lang=(.+)/)
    {
        $lstMark = setLstMark($1);
    }
    elsif (/^[^\-].*/)
    {
        $inputFileName = $_ . ".lst";
        $outputFileName = $_;
    }
}

## read input file
open(INPUTFILE, "<$inputFileName") ||
    die "Could not open $inputFileName for reading";
@inputText = <INPUTFILE>;
close(INPUTFILE);

## write output file
open(OUTPUTFILE, ">$outputFileName") ||
    die "Could not open $outputFileName for writing";
foreach $line (@inputText)
{
    unless ($line =~ /^\s*$lstMark/)
    {
        print OUTPUTFILE $line;
    }
}

close(OUTPUTFILE);


## end of main program
##############################################################

sub setLstMark
{
    my $opt = $_[0];

    $lstMark = "//LST" if ($opt =~ /(slash|c|cc|cpp|cxx|java|Java|d|D|cs|CS)/);
    $lstMark = "%%LST" if ($opt =~ /(percent|prolog|Prolog|pro|matlab|Matlab|tex|TeX|Tex|latex|Latex|LaTeX)/);
    $lstMark = ";;LST" if ($opt =~ /(semic|lisp)/);
    $lstMark = "\\#\\#LST"
        if ($opt =~ /(hash|make|octave|bash|sh|perl|AutoConf|html|xml|mathematica|pascal|python)/);
    $lstMark = "//LST" if ($opt =~ /(javash|JavaSH)/);
    $lstMark = "\\*\\*LST" if ($opt =~ /(star|f77)/);
    $lstMark = "!!LST" if ($opt =~ /(excl|f90|f95)/);
    $lstMark = "--LST" if ($opt =~ /(dash|sql)/);
    $lstMark = "''LST" if ($opt =~ /(apostr|basic)/);
    $lstMark = "\\?\\?LST" if ($opt =~ /(nolang)/);

    return $lstMark;
}
