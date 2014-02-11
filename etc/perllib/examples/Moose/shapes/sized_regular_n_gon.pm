# now we give it a size
package sized_regualr_n_gon;
use Moose;

BEGIN { extends 'regular_n_gon' }

has 'super_radius' => ( isa => 'Num', is => 'rw', lazy=>1, required=>0, trigger=>\&set_sub_n_side_from_super() ); # radius of superscribed circle
has 'sub_radius'   => ( isa => 'Num', is => 'rw', lazy=>1, required=>0, trigger=>\&set_super_n_side_from_sub() ); # radius of subcribed circle
has 'side_length'  => ( isa => 'Num', is => 'rw', lazy=>1, required=>0, trigger=>\&set_sub_n_super_from_side() );
 
sub perimeter {
    my $self = shift;
	return $self->sides() * $self->side_length();
}

sub area {
    my $self = shift;
	# number_of_triangles * ( 1/2 * Base * Height)
	return $self->sides() * $self->side_length() * $self->sub_radius() / 2.0;
}

sub set_sub_n_side_from_super {
	my ( $self, $super, $old_super) = @_;
	$self->{sub_radius}   = $super * cos( $self->internal_angle );
	$self->{side_length}  = $super * sin( $self->internal_angle );
}

sub set_super_n_side_from_sub {
	my ( $self, $sub, $old_sub) = @_;
	$self->{super_radius} = $sub / cos( $self->internal_angle );
	$self->{side_length}  = $sub / tan( $self->internal_angle );
}

sub set_sub_n_super_from_side {
	my ( $self, $side, $old_side) = @_;
	$self->{sub_radius}   = $side * tan( $self->internal_angle );
	$self->{super_radius} = $side / cos( $self->internal_angle );
}
 
# now we give it an angle
# now we give it an origin

1;

no Moose;
__PACKAGE__->meta->make_immutable;

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



