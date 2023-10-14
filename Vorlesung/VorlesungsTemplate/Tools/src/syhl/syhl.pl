#!/usr/bin/perl -w

use Env qw(HOME);
use lib "$HOME/LehreAllgemein/VorlesungsTemplate/Tools/src/syhl";
do "syhlfun.pl";

## set default values for parameters
$languageAbbr = "check";
$outputModeAbbr = "truecolor";
$inputFileName = "-";
$outputFileName = "-";
$printLineNumbers = 1;
$firstLineNumber = 1;
$texFrame = "no";

## check command line parameters
foreach (@ARGV)
{
    if (/^-lang=(.+)/)
    { $languageAbbr = $1; }
    elsif (/^-outmode=(.+)/)
    { $outputModeAbbr = $1; }
    elsif (/^-(nolinenums|nonums)$/)
    { $printLineNumbers = 0; }
    elsif (/^-(firstlinenum|firstline|first)=(.+)/)
    { $firstLineNumber = $2; }
    elsif (/^-texframe=(.+)/)
    { $texFrame = $1; }
    elsif (/^[^\-].*/)
    { $inputFileName eq "-" ? $inputFileName = $_ : $outputFileName = $_; }
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

$outputText = syhlfun($languageAbbr, $outputModeAbbr, $printLineNumbers,
                      $firstLineNumber, $texFrame, $inputFileName, $inputText);

## write output file
open(OUTPUTFILE, ">$outputFileName") ||
    die "Could not open $outputFileName for writing";
print OUTPUTFILE $outputText;
close(OUTPUTFILE);
