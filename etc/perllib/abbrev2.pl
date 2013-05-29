sub list_abbrevs {
  local(*abbrev)=@_;
  my($shortest,$longest,$working_value,$additional_characters);
  my($method,$return);
  my($delimiter0,$delimiter1);

  # given abbrev return array with values equal to the shortest unique values
  # of abbrev keys.  either spaced, capitalized, lowercase  OR delimited 

  $method='spaced';
  $method='capitalized';
  $method='lowercase';
  $method='delimited'; $delimiter0='(';  $delimiter1=')';
  $return='associative';
  $return='normal';

  foreach my $key ( sort keys %abbrev ) {
    my $value=$abbrev{$key};
    if ($value ne $working_value) {

    # clean up the previous key/value
      $longest=$old_key;
      if ( ! $shortest ) {
        $shortest=$key;
        $working_value=$value;
	next;
      }
      push(@values,$working_value);
      if ($shortest eq $longest) {
	if      ($method eq 'spaced') {
	  push(@uniques,$shortest);
	} elsif ($method eq 'uppercase' or $method eq 'capitalize') {
	  $shortest=~y/a-z/A-Z/;
	  push(@uniques,$shortest);
	} elsif ($method eq 'lowercase') {
	  $shortest=~y/A-Z/a-z/;
	  push(@uniques,$shortest);
	} elsif ($method eq 'delimited') {
#	  $shortest=~s/(.*)/${delimiter0}\1${delimiter1}/;
	  push(@uniques,$delimiter0 . $shortest . $delimiter1);
	}
      } else {
	($rest=$longest) =~ s/^${shortest}//;
	if      ($method eq 'spaced') {
	  push(@uniques,$shortest . " " . $rest);
	} elsif ($method eq 'uppercase' or $method eq 'capitalize') {
	  $shortest=~y/a-z/A-Z/;
	  push(@uniques,$shortest . " " . $rest);
	} elsif ($method eq 'lowercase') {
	  $shortest=~y/A-Z/a-z/;
	  push(@uniques,$shortest . " " . $rest);
	} elsif ($method eq 'delimited') {
	  push(@uniques,$delimiter0 . $shortest . $delimiter1 . $rest);
	}
      }
    # setup new key/value;
      $additional_characters=0;
      $shortest=$key;
      $working_value=$value;

    } else {
      $additional_characters++;
    }
    $old_key=$key;
  }
# clean up the last key/value
  $longest=$old_key;
  push(@values,$working_value);
  if ($shortest eq $longest) {
    if      ($method eq 'spaced') {
      push(@uniques,$shortest);
    } elsif ($method eq 'uppercase' or $method eq 'capitalize') {
      $shortest=~y/a-z/A-Z/;
      push(@uniques,$shortest);
    } elsif ($method eq 'lowercase') {
      $shortest=~y/A-Z/a-z/;
      push(@uniques,$shortest);
    } elsif ($method eq 'delimited') {
      push(@uniques,$delimiter0 . $shortest . $delimiter1);
    }
  } else {
    ($rest=$longest) =~ s/^${shortest}//;
    if      ($method eq 'spaced') {
      push(@uniques,$shortest . " " . $rest);
    } elsif ($method eq 'uppercase' or $method eq 'capitalize') {
      $shortest=~y/a-z/A-Z/;
      push(@uniques,$shortest . " " . $rest);
    } elsif ($method eq 'lowercase') {
      $shortest=~y/A-Z/a-z/;
      push(@uniques,$shortest . " " . $rest);
    } elsif ($method eq 'delimited') {
      push(@uniques,$delimiter0 . $shortest . $delimiter1 . $rest);
    }
  }
# push(@uniques,'not very funny!');
  if     ($return eq 'normal') {
    if (wantarray) {
      return @uniques;
    } else {
      return ( $#uniques + 1 - $[ );
    }
  } elsif ($return eq 'associative') {
    for ($i=$[; $i<=$#uniques; $i++) {
      eval "\$associative{\"$uniques[$i]\"}=\'$values[$i]\';" ;
#     print STDERR "\$associative{\"$uniques[$i]\"}=\'$values[$i]\';" ;
#     print STDERR "$associative{$uniques[$i]}\n";
    }
    return \%associative;
  }
}
1;
