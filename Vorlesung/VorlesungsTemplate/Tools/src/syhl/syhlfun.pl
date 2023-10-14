#!/usr/bin/perl -w

use Env qw(HOME);
use lib "$HOME/LehreAllgemein/VorlesungsTemplate/Tools/src/syhl";
use LanguageElement;
use Keyword;
use ClassName;
use EolComment;
use EolCommentRec;
use FortComment;
use ColNumComment;
use Delimited;
use DelimitedRec;
use InvisDelim;
use Directive;
use CppIncludeString;
use TeXEscape;
use StyleChange;
do "setupLanguage.pl";
do "setupOutputMode.pl";
use sort 'stable';

sub syhlfun
{
    my ($languageAbbr, $outputModeAbbr, $printLineNumbers, $firstLineNumber,
        $texFrame, $inputFileName, $inputText) = @_;

    my $language = checkLanguage($languageAbbr);
    my $outputMode = checkOutputMode($outputModeAbbr);

    ## try to set language if not yet set
    if ($language eq "check")
    { $language = guessLanguage($inputFileName); }

    ## set default language information
    my %languageData;
    $languageData{primaryKeywords} = [];
    $languageData{secondaryKeywords} = [];
    $languageData{docKeywords} = [];
    $languageData{classnameKeywords} = [];
    $languageData{extraKeywords} = [];
    $languageData{alsoLetters} = "A";
    $languageData{eolCommentsRec} = [];
    $languageData{eolDocComments} = [];
    $languageData{eolComments} = [];
    $languageData{perlEolComments} = [];
    $languageData{fortComments} = [];
    $languageData{colNumComments} = [];
    $languageData{brDocComments} = [];
    $languageData{brCommentsRec} = [];
    $languageData{brComments} = [];
    $languageData{normalStringRec} = [];
    $languageData{normalString} = [];
    $languageData{normalString2} = [];
    $languageData{backslashString} = [];
    $languageData{backslashString2} = [];
    $languageData{matlabString} = [];
    $languageData{directives} = [];
    $languageData{alwaysKeywords} = [];
    $languageData{cppIncludeString} = 0;
    $languageData{interactive} = [];
    $languageData{manualEmph} = [];
    $languageData{noKeyword} = [];
    $languageData{texEscape} = [];
    $languageData{literate} = [];
    $languageData{literateEval} = [];
    $languageData{sensitive} = 1;
    $languageData{showTabs} = 0;
    $languageData{extraLineskip} = 0;
    $languageData{altBasic} = "";

    ## set language information
    setupLanguageData($language, \%languageData);

    ## setup language data objects
    my @languageElements = ();
    foreach $k (@{$languageData{primaryKeywords}})
    { push @languageElements, Keyword->new($k, "primaryKeyword",
                                           $languageData{alsoLetters}); }
    foreach $k (@{$languageData{secondaryKeywords}})
    { push @languageElements, Keyword->new($k, "secondaryKeyword",
                                           $languageData{alsoLetters}); }
    foreach $k (@{$languageData{docKeywords}})
    { push @languageElements, Keyword->new($k, "docKeyword",
                                           $languageData{alsoLetters}); }
    foreach $k (@{$languageData{classnameKeywords}})
    { push @languageElements,
          ClassName->new(Keyword->new($k, "primaryKeyword",
                                      $languageData{alsoLetters})); }
    foreach $k (@{$languageData{extraKeywords}})
    { push @languageElements, Keyword->new($k, "extraKeyword",
                                           $languageData{alsoLetters}); }
    for ($i = 0; $i <= $#{$languageData{eolCommentsRec}}; $i += 3)
    { push @languageElements,
          EolCommentRec->new($languageData{eolCommentsRec}->[$i], "comment",
                             $languageData{eolCommentsRec}->[$i + 1],
                             $languageData{eolCommentsRec}->[$i + 2]); }
    for ($i = 0; $i <= $#{$languageData{eolDocComments}}; $i += 3)
    { push @languageElements,
          EolCommentRec->new($languageData{eolDocComments}->[$i], "docComment",
                             $languageData{eolDocComments}->[$i + 1],
                             $languageData{eolDocComments}->[$i + 2]); }
    foreach $k (@{$languageData{eolComments}})
    { push @languageElements, EolComment->new($k); }
    foreach $k (@{$languageData{perlEolComments}})
    { push @languageElements, EolComment->new($k, "comment", "perl"); }
    foreach $k (@{$languageData{fortComments}})
    { push @languageElements, FortComment->new($k); }
    foreach $k (@{$languageData{colNumComments}})
    { push @languageElements, ColNumComment->new($k); }
    for ($i = 0; $i <= $#{$languageData{brDocComments}}; $i += 4)
    { push @languageElements,
          DelimitedRec->new($languageData{brDocComments}->[$i],
                            $languageData{brDocComments}->[$i + 1], "docComment",
                            $languageData{brDocComments}->[$i + 2],
                            $languageData{brDocComments}->[$i + 3]); }
    for ($i = 0; $i <= $#{$languageData{brCommentsRec}}; $i += 4)
    { push @languageElements,
          DelimitedRec->new($languageData{brCommentsRec}->[$i],
                            $languageData{brCommentsRec}->[$i + 1], "comment",
                            $languageData{brCommentsRec}->[$i + 2],
                            $languageData{brCommentsRec}->[$i + 3]); }
    for ($i = 0; $i <= $#{$languageData{brComments}}; $i += 2)
    { push @languageElements,
          Delimited->new($languageData{brComments}->[$i],
                         $languageData{brComments}->[$i + 1], "comment"); }
    for ($i = 0; $i <= $#{$languageData{normalStringRec}}; $i += 4)
    { push @languageElements,
          DelimitedRec->new($languageData{normalStringRec}->[$i],
                            $languageData{normalStringRec}->[$i + 1],
                            "string",
                            $languageData{normalStringRec}->[$i + 2],
                            $languageData{normalStringRec}->[$i + 3]); }
    foreach $k (@{$languageData{normalString}})
    { push @languageElements, Delimited->new($k, $k, "string", "normal"); }
    for ($i = 0; $i <= $#{$languageData{normalString2}}; $i += 2)
    { push @languageElements,
          Delimited->new($languageData{normalString2}->[$i],
                         $languageData{normalString2}->[$i + 1], "string",
                         "normal"); }
    foreach $k (@{$languageData{backslashString}})
    { push @languageElements, Delimited->new($k, $k, "string", "backslash"); }
    for ($i = 0; $i <= $#{$languageData{backslashString2}}; $i += 2)
    { push @languageElements,
          Delimited->new($languageData{backslashString2}->[$i],
                         $languageData{backslashString2}->[$i + 1], "string",
                         "backslash"); }
    foreach $k (@{$languageData{matlabString}})
    { push @languageElements, Delimited->new($k, $k, "string", "matlab"); }
    foreach $k (@{$languageData{directives}})
    { push @languageElements, Directive->new($k); }
    if ($languageData{cppIncludeString})
    { push @languageElements, CppIncludeString->new; }
    $LanguageElement::sensitive = $languageData{sensitive};
    for ($i = 0; $i <= $#{$languageData{interactive}}; $i += 2)
    { push @languageElements,
          InvisDelim->new($languageData{interactive}->[$i],
                          $languageData{interactive}->[$i + 1], "interactive"); }
    for ($i = 0; $i <= $#{$languageData{manualEmph}}; $i += 2)
    { push @languageElements,
          InvisDelim->new($languageData{manualEmph}->[$i],
                          $languageData{manualEmph}->[$i + 1], "manualEmph"); }
    for ($i = 0; $i <= $#{$languageData{noKeyword}}; $i += 2)
    { push @languageElements,
          InvisDelim->new($languageData{noKeyword}->[$i],
                          $languageData{noKeyword}->[$i + 1], "basic"); }
    for ($i = 0; $i <= $#{$languageData{texEscape}}; $i += 3)
    { push @languageElements,
          TeXEscape->new($languageData{texEscape}->[$i],
                         $languageData{texEscape}->[$i + 1],
                         $languageData{texEscape}->[$i + 2]); }
    foreach $k (@{$languageData{alwaysKeywords}})
    { push @languageElements, Keyword->new($k, "primaryKeyword",
                                           $languageData{alsoLetters},
                                           "always"); }

    ## set output mode information
    my %outputStyle = ();
    if ($language eq "Algorithm" || $language =~ /Alg-(comment|string)/)
    { $outputMode .= "-alg"; }
    setupOutputStyles($outputMode, \%outputStyle, $inputFileName);
    if (!defined($outputStyle{extraLineskip}))
    { $outputStyle{extraLineskip} = $languageData{extraLineskip}; }
    $outputStyle{showTabs} = $languageData{showTabs};
    if ($languageData{altBasic} ne "")
    {
        $outputStyle{basic} = $outputStyle{$languageData{altBasic}};
    }

    ## do literate replacements first
    for ($i = 0; $i <= $#{$languageData{literate}}; $i += 2)
    {
        $inputText =~
            s/$languageData{literate}->[$i]/$languageData{literate}->[$i + 1]/g;
    }
    for ($i = 0; $i <= $#{$languageData{literateEval}}; $i += 2)
    {
        eval("\$inputText =~ s/$languageData{literateEval}->[$i]/" .
             "$languageData{literateEval}->[$i + 1]/g");
    }

    ## scan input
    my $scanText;
    if ($LanguageElement::sensitive)
    { $scanText = $inputText; }
    else
    { $scanText = uc($inputText); }
    my @styleChanges = ();
    foreach $langEl (@languageElements)
    {
        push @styleChanges, $langEl->addStyleChanges(\$scanText);
    }
    ## sort style change positions
    sub sortsc
    {
        $a->{position} <=> $b->{position} ||
            $a->{multiLineFirstPos} <=> $b->{multiLineFirstPos};
    }
    @styleChanges = sort sortsc @styleChanges;

    ## generate highlighted text
    my $formattedText = "";
    my $currentPosition = 0;
  FORMATLOOP: foreach $sc (@styleChanges)
  {
      next FORMATLOOP if ($sc->{position} == -1);
      if ($currentPosition > $sc->{position})
      {
          # disable continuations of skipped delimiters
          foreach $sc2 (@styleChanges)
          {
              $sc2->{position} = -1 if
                  ($sc2->{multiLineFirstPos} == $sc->{position}
                   && ref($sc->{syntaxElement}) eq ref($sc2->{syntaxElement})
                   && $sc2->{multiLineFirstPos} < $sc2->{position});
          }
          next FORMATLOOP;
      }
      $formattedText .= formatOutput(substr($inputText, $currentPosition,
                                            $sc->{position} - $currentPosition),
                                     \%outputStyle);
      $currentPosition = $sc->{position};
      $sc->{syntaxElement}->writeOutput(\$inputText, \$formattedText,
                                        \%outputStyle, \$currentPosition);
  }
    $formattedText .= formatOutput(substr($inputText, $currentPosition),
                                   \%outputStyle);

    ## generate output text lines
    my $outputText = "";

    $outputText .= $outputStyle{header};

    if ($texFrame =~ /t/)
    {
        $outputText .= "\\mbox{%\n\\rule[-2\\spHeight]{0.5pt}{\\spHeight}%\n" .
            "\\rule[-1\\spHeight]{\\linewidth}{0.5pt}%\n" .
            "\\rule[-2\\spHeight]{0.5pt}{\\spHeight}}%\n" .
            "\\vspace*{0mm}\\\\[-2mm]%\n";
    }

    my @outputLines = split(/\n/, $formattedText);
    my $currentLineNumber = $firstLineNumber;
    my $lineNumberFormat = "%" . int(log($#outputLines + $firstLineNumber)
                                     / log(10) + 1) . "i ";
    for ($l = 0; $l <= $#outputLines; $l++)
    {
        my $line = $outputLines[$l];
        if ($printLineNumbers && !$outputStyle->{tex} == 1)
        {
            $outputText .= $outputStyle{linenumber};
            $outputText .= sprintf $lineNumberFormat, $currentLineNumber;
            $currentLineNumber++;
        }
        if ($outputStyle->{tex} == 1)
        {
            if (!$outputStyle->{texinline})
            {
                $outputText .= "\\savebox{\\syhlLineBox}[\\linewidth][l]{\\scalebox{%\n";
                if (!$outputStyle->{texalg})
                {
                    $outputText .= "$outputStyle->{texscale}}";
                }
                else
                {
                    $outputText .= 0.8*$outputStyle->{texscale} . "}[$outputStyle->{texscale}]";
                }
                $outputText .= "{\\rule[-\\spDepth]{0mm}{\\spHeight+\\spDepth}\\:%\n";
            }
        }
        $outputText .= $outputStyle{basic};
        $outputText .= "$line";
        if ($outputStyle->{tex} == 1)
        {
            if (!$outputStyle->{texinline})
            {
                $outputText .= "}}%\n";
                $outputText .= "\\settoheight{\\syhlLineHeight}{\\usebox{\\syhlLineBox}}%\n";
                $outputText .= "\\settodepth{\\syhlLineDepth}{\\usebox{\\syhlLineBox}}%\n";
                # next two lines added for DejaVu Sans Mono
                $outputText .= "\\addtolength{\\syhlLineHeight}{-0.25mm}%\n";
                $outputText .= "\\addtolength{\\syhlLineDepth}{-0.25mm}%\n";
                $outputText .= "\\vspace*{\\syhlLineHeight}~%\n";
                $outputText .= "\\vspace*{-\\baselineskip}%\n";
                $outputText .= "\\\\\n";
                if ($printLineNumbers)
                {
                    $outputText .= $outputStyle{linenumber};
                    $outputText .= "\\makebox[0mm][r]{$currentLineNumber\\quad}";
                    $currentLineNumber++;
                    $outputText .= "$outputStyle{basic}%\n";
                }
                if ($texFrame =~ /lr/)
                {
                    $outputText .= "\\rule[-\\syhlLineDepth]{0.5pt}{\\syhlLineHeight+\\syhlLineDepth+0.5mm+$outputStyle{extraLineskip}mm}%\n";
                }
                $outputText .= "\\usebox{\\syhlLineBox}%\n";
                $outputText .= "\\vspace*{-\\baselineskip}%\n";
                $outputText .= "\\vspace*{\\syhlLineDepth}%\n";
                $outputText .= "\\vspace*{0.5mm}%\n";
                if ($outputStyle{extraLineskip} > 0)
                {
                    $outputText .= "\\vspace*{$outputStyle{extraLineskip}mm}%\n";
                }
                if ($texFrame =~ /lr/)
                {
                    $outputText .= "\\rule[-\\syhlLineDepth]{0.5pt}{\\syhlLineHeight+\\syhlLineDepth+0.5mm+$outputStyle{extraLineskip}mm}%\n";
                }
            }
            if ($l < $#outputLines || !$outputStyle->{texinline})
            {
                $outputText .= "\\\\%%%\n";
            }
        }
        else
        {
            $outputText .= "\n";
        }
    }

    if ($texFrame =~ /b/)
    {
        $outputText .= "\\mbox{%\n\\rule[-1mm]{0.5pt}{\\spHeight}%\n" .
            "\\rule[-1mm]{\\linewidth}{0.5pt}%\n" .
            "\\rule[-1mm]{0.5pt}{\\spHeight}}%\n" .
            "\\vspace*{-10mm}";
    }

    $outputText .= $outputStyle{footer};

    return $outputText;
}

## end of syhlfun
##############################################################

sub formatOutput
{
    my $unformattedString = $_[0];
    $outputStyle = \%{$_[1]};
    my $where = defined($_[2]) ? $_[2] : "plain";

    $formattedString = $unformattedString;
    if (!$outputStyle->{showTabs})
    {
        $formattedString =~ s/\t/        /g;
    }
    if (!defined($outputStyle->{tex}))
    { print "$unformattedString\n"; }
    if ($outputStyle->{tex} == 1 && $where ne "inEscape")
    {
        $formattedString =~ s/{/~backslash~{/g;
        $formattedString =~ s/}/~backslash~}/g;
        $formattedString =~ s/\\/\\symbol{92}/g;
        $formattedString =~ s/~backslash~\{/\\{/g;
        $formattedString =~ s/~backslash~}/\\}/g;
        $formattedString =~ s/ /\\ /g;
        $formattedString =~ s/_/\\_{}/g;
        $formattedString =~ s/\$/\\string\$/g;
        $formattedString =~ s/\#/\\string\#/g;
        $formattedString =~ s/\&/\\string&/g;
        $formattedString =~ s/\%/\\%/g;
        $formattedString =~ s/\"/{}\\string\"{}/g;
        $formattedString =~ s/~/\\string~/g;
        $formattedString =~ s/\^/\\string\^/g;
        $formattedString =~ s/-/-{}/g;
        $formattedString =~ s/<</<{}<{}/g;
        $formattedString =~ s/>>/>{}>{}/g;
        $formattedString =~ s/</\\string</g;
        $formattedString =~ s/>/\\string>/g;
        #$formattedString =~ s/'''/'{}'{}'/g if (!$outputStyle->{texalg});
        #$formattedString =~ s/''/'{}'/g if (!$outputStyle->{texalg});
        $formattedString =~ s/'/{}'{}/g if (!$outputStyle->{texalg});
        #$formattedString =~ s/`/\\mbox{}̀\\mbox{}/g if (!$outputStyle->{texalg});
        $formattedString =~ s/`/\\mbox{}̀ /g if (!$outputStyle->{texalg});
        $formattedString =~ s/›/\\hspace*{1ex}/g;
        $formattedString =~ s/‹/\\hspace*{-1ex}/g;
    }
    if ($outputStyle->{showTabs})
    {
        $formattedString =~ s/\t/$outputStyle->{tabulator}/g;
    }
    if ($where eq "inString")
    {
        $formattedString =~ s/\\ /$outputStyle->{stringSpace}/g;
    }

    return $formattedString;
}
