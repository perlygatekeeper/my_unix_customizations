package regular_n_gon;
use Moose;
use Carp;
 
has 'sides'        => ( isa => 'Int', is => 'rw', required => 1 );
 
sub internal_angle {
    my $self = shift;
	return 360.0/$self->sides();
}


# now we give it a size

package sized_regualr_n_gon;

extends 'regular_n_gon';

has 'super_radius' => ( isa => 'Num', is => 'rw' ); # radius of superscribed circle
has 'sub_radius'   => ( isa => 'Num', is => 'rw' ); # radius of subcribed circle
has 'side_length'  => ( isa => 'Num', is => 'rw' );
 
sub perimeter {
    my $self = shift;
	return $self->sides() * $self->side_length();
}

sub area {
    my $self = shift;
	# number_of_triangles * ( 1/2 * Base * Height)
	return $self->sides() * $self->side_length() * $self->sub_radius() / 2.0;
}
 
sub set_to {
    @_ == 3 or croak "Bad number of arguments";
    my $self = shift;
    my ($x, $y) = @_;
    $self->x($x);
    $self->y($y);
}

# now we give it an angle
# now we give it an origin
