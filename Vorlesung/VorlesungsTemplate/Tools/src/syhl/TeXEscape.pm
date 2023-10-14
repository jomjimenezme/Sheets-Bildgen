package TeXEscape;

@ISA = (LanguageElement);

use List::Util qw(min max);

sub new
{
    my ($class, $ec, $eb, $ee) = @_;
    my $self = {};
    $self->{escChar} = $ec;
    $self->{escBeg} = $eb;
    $self->{escEnd} = $ee;
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    my $self = $_[0];
    $scanText = \${$_[1]};
    @changes = ();
    $lastPos = 0;
    while (($lastPos = index($$scanText, $self->{escChar}, $lastPos)) > -1)
    {
        push @changes, StyleChange->new($lastPos, $self);
        $escapeEndPos = index($$scanText, $self->{escChar}, $lastPos + 1);
        $lastPos = $escapeEndPos + length($self->{escChar});
    }
    return @changes;
}

sub writeOutput
{
    my $self = $_[0];
    $inputText = \${$_[1]};
    $formattedText = \${$_[2]};
    $outputStyle = \%{$_[3]};
    $currentPos = \${$_[4]};
    ## escape ends at next self->escChar
    $escapeEndPos = index($$inputText, $self->{escChar},
                          $$currentPos + 1) + length($self->{escChar});
    $where = "inEscape";
    $$formattedText .= $outputStyle->{texEscape} . $self->{escBeg};
    $$formattedText .= main::formatOutput(substr($$inputText, $$currentPos
                                                 + length($self->{escChar}),
                                                 $escapeEndPos - $$currentPos -
                                                 2 * length($self->{escChar})),
                                          $outputStyle, $where);
    $$formattedText .= $self->{escEnd} . $outputStyle->{basic};
    $$currentPos = $escapeEndPos;
}

1;
