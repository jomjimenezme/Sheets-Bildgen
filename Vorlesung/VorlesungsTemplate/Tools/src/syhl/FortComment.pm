package FortComment;

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
    $lastPos = 0;
    while (($lastPos = index($$scanText, $self->{beg}, $lastPos)) > -1)
    {
        if ($lastPos == 0 || substr($$scanText, $lastPos - 1, 1) eq "\n")
        { push @changes, StyleChange->new($lastPos, $self); }
    }
    continue
    { $lastPos++; }

    return @changes;
}

1;
