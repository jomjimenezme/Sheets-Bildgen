package ClassName;

@ISA = (LanguageElement);

sub new
{
    my ($class, $k) = @_;
    my $self = {};
    $self->{keyword} = $k;
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    my $self = $_[0];
    $scanText = \${$_[1]};
    @changes = $self->{keyword}->addStyleChanges($scanText);
    @cnchanges = ();

    foreach $ch (@changes)
    {
        $cnpos = $ch->{position} + length($self->{keyword}->{word});
        while (substr($$scanText, $cnpos, 1) =~ /\s/ ||
               substr($$scanText, $cnpos, 2) =~ /{\S/)
        { $cnpos++; }
        if (substr($$scanText, $cnpos, 1) =~ /\w/)
        { push @cnchanges, StyleChange->new($cnpos, $self); }
    }

    return (@changes, @cnchanges);
}

sub writeOutput
{
    my $self = $_[0];
    $inputText = \${$_[1]};
    $formattedText = \${$_[2]};
    $outputStyle = \%{$_[3]};
    $currentPosition = \${$_[4]};
    $cnlen = 1;
    while ($$currentPosition + $cnlen < length($$inputText)
           && substr($$inputText, $$currentPosition + $cnlen, 1) =~ /\w|[äöü]/)
    { $cnlen++; }
    $$formattedText .= $outputStyle->{className};
    $$formattedText .= main::formatOutput(substr($$inputText, $$currentPosition,
                                                 $cnlen), $outputStyle);
    $$formattedText .= $outputStyle->{basic};
    $$currentPosition += $cnlen;
}

1;
