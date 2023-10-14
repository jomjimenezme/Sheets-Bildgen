package EolCommentRec;

use EolComment;
use Env qw(HOME);
use lib "$HOME/LehreAllgemein/VorlesungsTemplate/Tools/src/syhl";
do "syhlfun.pl";

@ISA = (EolComment);

sub new
{
    my ($class, $b, $t, $l, $o) = @_;
    my $self = $class->SUPER::new($b, $t);
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
        push @changes, StyleChange->new($lastPos, $self);
    }
    continue
    { $lastPos++; }

    return @changes;
}

sub writeOutput
{
    my $self = $_[0];
    $inputText = \${$_[1]};
    $formattedText = \${$_[2]};
    $outputStyle = \%{$_[3]};

    ## switch outmode to ansi if already in ansi (i.e. non-TeX) mode
    if ($outputStyle->{basic} =~ /^\[/)
    { $self->{outmode} = "ansi"; }

    $currentPosition = \${$_[4]};
    $commentEndPosition = index($$inputText, "\n", $$currentPosition + 1);
    if ($commentEndPosition == -1) ## no eol after last line
    { $commentEndPosition = length($$inputText); }
    $$formattedText .= $outputStyle->{$self->{type}};
    $$formattedText .= main::formatOutput($self->{beg}, $outputStyle);
    $formattedEscapeText = syhlfun($self->{lang}, $self->{outmode}, 0, 1, "",
                                   "-",
                                   substr($$inputText, $$currentPosition
                                          + length($self->{beg}),
                                          $commentEndPosition
                                          - $$currentPosition
                                          - length($self->{beg})));
    chomp($formattedEscapeText);
    $formattedEscapeText =~ s/%\n//g;
    $$formattedText .= $formattedEscapeText;
    $$formattedText .= $outputStyle->{basic};
    $$currentPosition = $commentEndPosition;
}

1;
