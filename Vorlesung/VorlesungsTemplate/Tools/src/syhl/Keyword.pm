package Keyword;

@ISA = (LanguageElement);

sub new
{
    my ($class, $w, $t, $l, $a) = @_;
    my $self = {};
    $self->{word} = $w;
    $self->{type} = $t;
    $self->{letters} = $l;
    $self->{always} = defined($a);
    bless $self, $class;
    return $self;
}

sub addStyleChanges
{
    my $self = $_[0];
    $scanText = \${$_[1]};
    @changes = ();
    $lastPos = 0;
    if ($LanguageElement::sensitive)
    { $caseword = $self->{word}; }
    else
    { $caseword = uc($self->{word}); }
  LOOP: while (($lastPos = index($$scanText, $caseword, $lastPos)) > -1)
  {
      if (!$self->{always} &&
          (($lastPos > 0 && substr($$scanText, $lastPos - 1, 1)
            =~ /(\w|$self->{letters})/) ||
           ($lastPos + length($caseword) < length($$scanText) &&
            substr($$scanText, $lastPos + length($caseword), 1)
            =~ /(\w|$self->{letters})/)))
      { next LOOP; }
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
    $currentPosition = \${$_[4]};
    $$formattedText .= $outputStyle->{$self->{type}};
    $$formattedText .= main::formatOutput(substr($$inputText, $$currentPosition,
                                                 length($self->{word})),
                                          $outputStyle);
    $$formattedText .= $outputStyle->{basic};
    $$currentPosition += length($self->{word});
}

1;
