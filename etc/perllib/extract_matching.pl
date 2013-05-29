#   ---   ---   ---
sub extract_matching {
# subroutine to extract text between matching delimiters
# from a single string, latter also for array, or filehandle
# while allowing for escaped delimiters and # like comment lines

  my($debug)=0;
  my($string,$start_regexp,$delimiter1,$delimiter2,$escape,$comment)
  =@_;
  my(@sub_strings,@characters,$matching,@matched);
  $delimiter1 = ($delimiter1) ? $delimiter1 : '{' ;
  $delimiter2 = ($delimiter2) ? $delimiter2 : '}' ;
  $escape     = ($escape)     ? $escape     : '\\' ;
  $comment    = ($comment)    ? $comment    : '%' ;
  if ( $comment eq 'NULL' ) { $comment=''; }
  if ( $escape  eq 'NULL' ) { $escape=''; }
#  $/='';
# $*=1; #enable paragraph mode & mulitline pattern matching.
  $eats_escapes=0;

  print DEBUG "delim1:  '$delimiter1'\t" if ($debug);
  print DEBUG "delim2:  '$delimiter2'\t" if ($debug);
  print DEBUG "escape:  '$escape'\t"     if ($debug);
  print DEBUG "comment: '$comment'\n"    if ($debug);

  # protect the regexp characters ' ^ $ ? * + ( ) { } [ ] < > \ / . '
  $start_regexp=~s/([\$\^*\[\]{}.<>()+?\/\\])/\\\1/g;
  print DEBUG "string: '$string'\n" if ($debug>2);
  print DEBUG "start_regexp: '$start_regexp'\n" if ($debug);

  if ($start_regexp) {
    @sub_strings=split(/$start_regexp/,$string); 
  } else {
    @sub_strings=('',$string);  # no starting regexp, just examine whole string
  }

  print DEBUG "number of substrings: '$#sub_strings'\n" if ($debug);

# if user specified a starting regexp, and none was found return NAK now
  if ($start_regexp && ( $#sub_strings < (1) ) ) {
    if ( ! wantarray ) {
      return '';
      return 'NULL';
    } else {
      return ();
      return ('NULLa','NULLb','NULLc');
    }
  }

  if ($debug>1) {
    local($i)=0;
    print DEBUG "----- begin substrings-----\n";
    foreach $sub_string ( @sub_strings ) {
      print DEBUG "  substring[$i]: '$sub_string'\n";
      $i++;
    }
    print DEBUG "-----  end  substrings-----\n";
  }
  @matched=();
  foreach $sub_string ( @sub_strings[ ($[+1) .. $#sub_strings ] ) {

    print DEBUG "substring: '$sub_string'\n" if ($debug>1);
    next if ($sub_string =~ /^$/); # next sub string if null string

    $matching='';
    $comment_on= $accumulating= $delimiter_count=0;

    @characters=split(//,$sub_string); 
    foreach $char (@characters) {
      if ( $comment_on) {
        print DEBUG "$comment" if ($debug == -1);
        if ($char eq "\n") {
          $comment_on=0;
          print DEBUG "\n" if ($debug == -1);
        }
        next;
      }
      if ( $escaped) {
        $escaped=0;
        if ($accumulating && $delimiter_count) {
          if ($eats_escapes) {
            $matching.=$char;
          } else {
            $matching.="$escape$char";
          }
        }
        next;
      }
      if      ( $char eq "$escape" ) {
        $escaped=1;
        next;
      } elsif ( $char eq "$comment" ) {
        $comment_on=1;
        if ( $matching !~ /\n$/ ) { $matching.="\n"; } 
        next;
      } elsif ( $char eq "$delimiter1" ) {
        if ($accumulating && $delimiter_count) {
          $matching.=$char;
        }
        $delimiter_count++;
        $accumulating=1;
      } elsif ( $char eq "$delimiter2" ) {
        $delimiter_count--;
        if ($accumulating) {
          if ($delimiter_count) {
            $matching.=$char;
          } else {
            $accumulating=0;
            last;
          }
        }
      } elsif ($accumulating) {
        if ($delimiter_count) {
#         die "newline" if ( $char eq "\n");
          $matching.=$char;
        } else {
          last;
        }
      } # if elsif else structure on character type
    } # foreach loop on characters of given substring
    print DEBUG "end of foreach sub_string loop\n" if ($debug>1);
    if (! wantarray ) {
      return "$matching";
    } else {
      push(@matched,$matching);
    }

  } # while loop on substrings

  print DEBUG "just before returns $#matched\n" if ($debug>1);
  if (! wantarray ) {
    if ($matching) {
      return "$matching";
    } else {
      return '';
    }
  } else {
    return @matched;
  }

}
1;
