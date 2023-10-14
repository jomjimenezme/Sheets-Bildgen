package StyleChange;

sub new
{
    my ($class, $p, $s, $mfp) = @_;
    my $self = {};
    $self->{position} = $p;
    $self->{syntaxElement} = $s;
    $self->{multiLineFirstPos} = defined($mfp) ? $mfp : $p;
    bless $self, $class;
    return $self;
}

1;
