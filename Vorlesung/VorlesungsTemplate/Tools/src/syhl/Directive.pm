package Directive;

@ISA = (LanguageElement);

sub new
{
    my ($class, $w) = @_;
    my $self = {};
    $self->{word} = $w;
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
      if (($lastPos > 1 && substr($$scanText, $lastPos - 2, 2) ne "\n#") ||
          ($lastPos > 0 && substr($$scanText, $lastPos - 1, 1) ne "#") ||
          ($lastPos + length($caseword) < length($$scanText) &&
           substr($$scanText, $lastPos + length($caseword), 1) =~ /\w/))
      { next LOOP; }
      push @changes, StyleChange->new($lastPos - 1, $self);
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
    $$formattedText .= $outputStyle->{directive};
    $$formattedText .= main::formatOutput(substr($$inputText, $$currentPosition,
                                                 length($self->{word}) + 1),
                                          $outputStyle);
    $$formattedText .= $outputStyle->{basic};
    $$currentPosition += length($self->{word}) + 1;
}

1;
