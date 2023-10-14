#!/usr/bin/perl -w

use POSIX qw(:termios_h);
use FileHandle;

$errCol = "\033[0;38;2;180;0;0m";
$err2Col = "\033[0;38;2;240;0;0m";
$outCol = "\033[0;38;2;0;0;180m";
$imgoutCol = "\033[0;38;2;0;250;130m";
$imgoutCol2 = "\033[0;38;2;250;170;130m";
$secCol = "\033[0;38;2;237;48;112;1m";

## do not buffer output
STDOUT->autoflush;

## store old termios-settings
$termori = POSIX::Termios->new;
$termori->getattr();

## copy settings and change attributes
$termnoenter = $termori;
$tne_clflags = $termnoenter->getcflag;
$tne_clflags &= ~ICANON;
$tne_clflags &= ~ECHO;
$termnoenter->setattr(0, &POSIX::TCSANOW);

## filter output

$c = 'X';
$clast1 = 'X';
$clast2 = 'X';
$clast3 = 'X';
$pagenum = 0;
$pagenumstart = 0;
$chapname = 0;
$error = 0;
$anyerror = 0;
$errorOnPage = 0;
$pagetotal = 0;
$pagenumStr = "";
$oldpagenumStr = "invalid";
$chapnameStr = "";
$progressStr = "";
$errorCount = 0;
$errorMsgs = "";

print $outCol;
while (sysread(STDIN, $c, 1))
{
    if ($c eq '[')
    {
        ## start of a page number?
        $pagenumstart = 1;
    }
    elsif ($pagenumstart && ($c ge '0' && $c le '9'))
    {
        ## it was indeed the start of a page number
        $pagenumstart = 0;
        $pagenum = 1;
        $oldpagenumStr = $pagenumStr;
        $pagenumStr = $c;
    }
    elsif ($pagenumstart && $c eq '@')
    {
        ## it was in fact the name of a chapter
        $pagenumstart = 0;
        $chapname = 1;
        $chapnameStr = "";
    }
    elsif ($pagenumstart && !($c ge '0' && $c le '9'))
    {
        ## it was just []
        $pagenumstart = 0;
    }
    elsif ($pagenum && ($c ge '0' && $c le '9'))
    {
        ## next digit of page number
        $pagenumStr .= $c;
    }
    elsif ($pagenum && !($c ge '0' && $c le '9'))
    {
        ## additional information after / end of page number
        if (int($pagenumStr) % 70 == 1 && length($progressStr) > 0)
        {
            print "\n";
            $progressStr = "";
            $errorCount = 0;
        }
        if (!$errorOnPage)
        {
            ## for colour gradient
            #$pagenum = int($pagenumStr);
            #if ($pagenum <= 70)
            #{
            #    $r = 0;
            #    $g = int(3.6 * $pagenum);
            #    $b = 255 - $g;
            #}
            #elsif ($pagenum <= 140)
            #{
            #    $r = int(3.6 * ($pagenum - 70));
            #    $g = 255 - $r;
            #    $b = $r;
            #}
            #else
            #{
            #    $t = int(3.6 * ($pagenum - 140));
            #    $r = 255 - $t;
            #    $g = 3;
            #    $b = 252;
            #}
            #$proCol = "\033[0;38;2;${r};${g};${b}m";
            #$progressStr .= $proCol . "•" . $outCol;
            ## just one colour
            if ($pagenumStr ne $oldpagenumStr)
            {
                $progressStr .= $outCol . "•";
                $numcolpages = 0;
            }
            else # i.e. after image page
            {
                if (substr($progressStr, length($progressStr) - 3, 3) eq "•")
                { # and not after an error "E"
                    if ($numcolpages % 2 == 0)
                    {
                        $progressStr = substr($progressStr, 0,
                                              length($progressStr) - 3)
                            . $imgoutCol . "•";
                    }
                    else
                    {
                        $progressStr = substr($progressStr, 0,
                                              length($progressStr) - 3)
                            . $imgoutCol2 . "•";
                    }
                    $numcolpages++;
                }
            }
        }
        else
        {
            if ($errorCount == 1)
            { $progressStr .= "${errCol}E$outCol"; }
            else
            { $progressStr .= "${err2Col}E$outCol"; }
            $errorOnPage = 0;
        }
        printf "$outCol\015%3s", $pagenumStr;
        if ($errorCount == 0)
        {
            print "      ";
        }
        else
        {
            printf "$errCol %4i $outCol", $errorCount;
        }
        print $progressStr;
        $pagenum = 0;
    }
    elsif ($chapname && $c ne ']')
    {
        ## letter inside chapter name
        $chapnameStr .= $c;
    }
    elsif ($chapname)
    {
        ## end of chapter name
        print "\n$secCol$chapnameStr$outCol\n";
        $progressStr = "";
        $chapname = 0;
        $errorCount = 0;
        $pagenumStr = "invalid"; # for comparison with $oldpagenumStr
    }
    elsif ($c eq '!' && $clast1 eq "\n")
    {
        ## error or warning
        if ($errorCount == 1 || $errorCount == 3)
        { $errorMsgs .= $errCol; }
        else
        { $errorMsgs .= $err2Col; }
        $error = 3;
    }
    elsif ($error == 3 && $c eq '.' && $clast1 eq 'l' && $clast2 eq "\n")
    {
        ## line number of an error
        $anyerror = 1;
        $errorCount++;
        $errorOnPage = 1;
        $error = 2;
    }
    elsif ($error == 2 && $c eq "\n")
    {
        ## TeX-source before error
        $error = 1;
    }
    elsif ($error == 1 && $c eq "\n")
    {
        ## TeX-source after error
        $error = 0;
    }
    elsif ($error == 3 && $c eq 'd' && $clast1 eq 'p' && $clast2 eq ' '
           && $clast3 eq '!')
    {
        ## pdfTeX warning
        $error = 101;
    }
    elsif ($error == 101 && ($c eq "\n" && $clast1 eq "\n" ||
                             $c eq "\n" && $clast1 eq "y" && $clast2 eq "t"))
    {
        ## end of pdfTeX warning
        $error = 0;
        print $outCol;
    }
    elsif ($c ge '0' && $c le '9' && $clast1 eq '('
           && ($clast3 eq 'i' || $clast3 eq 'f'))
    {
        ## total number of pages
        $pagetotal = 1;
        print "\n";
    }
    elsif ($pagetotal && $c eq ')')
    {
        ## end of total number of pages
        $pagetotal = 0;
    }
    if ($error > 0 && $errorCount <= 3)
    {
        $errorMsgs .= $c;
    }
    elsif ($pagetotal)
    {
        print $c;
    }
    if ($pagenum && $c eq ']')
    {
        ## end of page number
        $pagenum = 0;
    }
    ($clast1, $clast2, $clast3) = ($c, $clast1, $clast2);
}
print "\n";
if ($anyerror)
{ print "$errCol$errorMsgs$outCol\n"; }

## restore original settings
$termori->setattr(0, &POSIX::TCSANOW);

if ($anyerror)
{ exit 1; }
exit 0;
