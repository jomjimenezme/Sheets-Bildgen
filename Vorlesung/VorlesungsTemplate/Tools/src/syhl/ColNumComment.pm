package ColNumComment;

use EolComment;

@ISA = (EolComment);

sub new
{
    my ($class, $b) = @_;
    my $self = $class->SUPER::new($b);
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    my $self = $_[0];
    $scanText = \${$_[1]};
    @changes = ();
    $lastCRPos = 0;
    while (($nextCRPos = index($$scanText, "\n", $lastCRPos)) > -1)
    {
        if ($nextCRPos - $lastCRPos > $self->{beg})
        { push @changes, StyleChange->new($lastCRPos + $self->{beg} - 1,
                                          $self); }
    }
    continue
    { $lastCRPos = $nextCRPos + 1; }

    return @changes;
}

1;
