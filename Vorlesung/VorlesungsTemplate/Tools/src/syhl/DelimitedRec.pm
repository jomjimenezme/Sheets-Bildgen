package DelimitedRec;

## This class is only meant for comments and standard strings
## i.e. neither matlab nor backslash-escaped strings

use Delimited;
use Env qw(HOME);
use lib "$HOME/LehreAllgemein/VorlesungsTemplate/Tools/src/syhl";
do "syhlfun.pl";

@ISA = (Delimited);

use List::Util qw(min max);

sub new
{
    my ($class, $b, $e, $t, $l, $o) = @_;
    my $self = $class->SUPER::new($b, $e, $t, "none");
    $self->{lang} = $l;
    $self->{outmode} = $o;
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    my $self = $_[0];
    $scanText = \${$_[1]};
    @changes = ();
    $lastPos = 0;
    while (($lastPos = index($$scanText, $self->{beg}, $lastPos)) > -1)
    {
        ## found delimiter start
        push @changes, StyleChange->new($lastPos, $self);
        $commentEndPos = $lastPos + length($self->{beg});
        $commentEndPos = index($$scanText, $self->{end}, $commentEndPos);
        return @changes if $commentEndPos == -1;
        ## check for continued comment lines
        $lastEolPos = $lastPos;
        while (($lastEolPos = index($$scanText, "\n", $lastEolPos))
               < $commentEndPos)
        {
            last if $lastEolPos == -1;
            push @changes, StyleChange->new($lastEolPos + 1, $self);
            $lastEolPos++;
        }
        $lastPos = $commentEndPos + length($self->{end}) if $lastPos > -1;
    }
    return @changes;
}

sub writeOutput
{
    my $self = $_[0];
    $inputText = \${$_[1]};
    $formattedText = \${$_[2]};
    my $outputStyle = \%{$_[3]};

    ## switch outmode to ansi if already in ansi (i.e. non-TeX) mode
    if ($outputStyle->{basic} =~ /^\[/)
    { $self->{outmode} = "truecolor"; } # was ansi

    my $currentPos = \${$_[4]};
    ## comment ends at self->end or at eol
    my $commentEndPos;
    if ($$currentPos != 0 && substr($$inputText, $$currentPos - 1, 1) eq "\n"
        && substr($$inputText, $$currentPos, length($self->{beg}))
        ne $self->{beg})
    {
        $continued = 1;
        $commentEndPos = index($$inputText, $self->{end}, $$currentPos);
    }
    else
    {
        $continued = 0;
        $commentEndPos = index($$inputText, $self->{end},
                               $$currentPos + length($self->{beg}));
    }
    my $eolPos = index($$inputText, "\n", $$currentPos) - 1;
    if ($eolPos > -1 && $eolPos < $commentEndPos)
    {
        $commentEndPos = $eolPos;
        $untilEol = 1;
    }
    else
    {
        $untilEol = 0;
    }
    $$formattedText .= $outputStyle->{$self->{type}};
    if (!$continued)
    {
        $$formattedText .= main::formatOutput($self->{beg}, $outputStyle);
    }
    $fetBeg = $$currentPos + ($continued ? 0 : length($self->{beg}));
    $fetLen = $commentEndPos - $fetBeg
        + ($untilEol ? 1 : 0);
    if ($fetLen >= 1)
    {
        $formattedEscapeText = syhlfun($self->{lang}, $self->{outmode}, 0, 1,
                                       "", "-",
                                       substr($$inputText, $fetBeg, $fetLen));
        chomp($formattedEscapeText);
        $formattedEscapeText =~ s/%\n//g;
        $$formattedText .= $formattedEscapeText;
    }
    $$formattedText .= $outputStyle->{$self->{type}};
    if (!$untilEol)
    {
        $$formattedText .= main::formatOutput($self->{end}, $outputStyle);
    }
    $$formattedText .= $outputStyle->{basic};
    $commentEndPos += ($untilEol ? 1 : length($self->{end}));
    $$currentPos = $commentEndPos;
}

1;
