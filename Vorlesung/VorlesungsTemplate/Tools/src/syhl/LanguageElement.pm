package LanguageElement;

sub new
{
    my ($class) = @_;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    die 'abstract method called';
}

sub writeOutput
{
    die 'abstract method called';
}

1;
