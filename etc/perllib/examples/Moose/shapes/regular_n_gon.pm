package regular_n_gon;
use Moose;
use Carp;
use Math::Trig;
 
has 'sides'         => ( isa => 'Int', is => 'rw', required => 1 );
has 'interal_angle' => ( isa => 'Num', is => 'rw', required => 1, builder=\&find_internal_angle );
 
sub find_internal_angle {
    my $self = shift;
	return undef if (not $self->sides());
	return pi2/$self->sides();
}

sub in_degrees {
    my $self  = shift;
    my $angle = shift;
	return $angle*180/pi;
}

# now we give it a size

package sized_regualr_n_gon;

extends 'regular_n_gon';

has 'super_radius' => ( isa => 'Num', is => 'rw', trigger=>\&set_sub_n_side_from_super() ); # radius of superscribed circle
has 'sub_radius'   => ( isa => 'Num', is => 'rw', trigger=>\&set_super_n_side_from_sub() ); # radius of subcribed circle
has 'side_length'  => ( isa => 'Num', is => 'rw', trigger=>\&set_sub_n_super_from_side() );
 
sub perimeter {
    my $self = shift;
	return $self->sides() * $self->side_length();
}

sub area {
    my $self = shift;
	# number_of_triangles * ( 1/2 * Base * Height)
	return $self->sides() * $self->side_length() * $self->sub_radius() / 2.0;
}

sub set_sub_n_side_from_super { # appropriate trig calc goes here
	my $self = shift;
	$self->{sub_radius}   = $self->{super_radius} * cos($self->{internal_angle});
	$self->{side_length}  = $self->{super_radius} * sin($self->{internal_angle});
}

sub set_super_n_side_from_sub { # appropriate trig calc goes here
	$self->{super_radius} = $self->{sub_radius} / cos($self->{internal_angle});
	$self->{side_length}  = $self->{sub_radius} / tan($self->{internal_angle});
}

sub set_sub_n_super_from_side { # appropriate trig calc goes here
	$self->{sub_radius}   = $self->{side_length} * tan($self->{internal_angle})
	$self->{super_radius} = $self->{side_length} / cos($self->{internal_angle});
}
 
# now we give it an angle
# now we give it an origin


__END__

    .
    |\
    | \
   S|  \
   u|   \   _Super
   b|    \ /
    |     \
    |      \
    |      a\        a = internal_angle / 2
    |________\
	  hSide          hSide = Side / 2


  hSide = sin(a)    hSide = sin(a) * Super    Super = hSide/sin(a)
  Super

  _Sub_ = cos(a)      Sub = cos(a) * Super    Super = Sub/cos(a)
  Super

  _Sub_ = tan(a)      Sub = tan(a) * hSide    hSide = Sub/tan(a)
  hSide



