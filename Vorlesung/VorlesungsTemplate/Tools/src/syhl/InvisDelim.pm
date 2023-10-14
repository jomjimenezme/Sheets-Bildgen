package InvisDelim;

@ISA = (Delimited);

use List::Util qw(min max);

sub new
{
    my ($class, $b, $e, $t) = @_;
    my $self = $class->SUPER::new($b, $e, $t);
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
        $commentEndPos = $lastPos + length($self->{beg});
        $commentEndPos = index($$scanText, $self->{end}, $commentEndPos);
        $lastPos = $commentEndPos + length($self->{end}) if $lastPos > -1;
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
    $commentEndPos = index($$inputText, $self->{end},
                           $$currentPos + length($self->{beg}));
    $commentEndPos += length($self->{end});
    $$formattedText .= $outputStyle->{$self->{type}};
    $$formattedText .= main::formatOutput(substr($$inputText, $$currentPos
                                                 + length($self->{beg}),
                                                 $commentEndPos - $$currentPos
                                                 - length($self->{beg})
                                                 - length($self->{end})),
                                          $outputStyle, $where);
    $$formattedText .= $outputStyle->{basic};
    $$currentPos = $commentEndPos;
}

1;
