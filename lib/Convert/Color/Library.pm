package Convert::Color::Library;

use strict;
use base qw( Convert::Color::RGB8 );

use constant COLOR_SPACE => 'lib';

use Carp;

our $VERSION = '0.01';

=head1 NAME

C<Convert::Color::Library> - named lookup of colors from C<Color::Library>

=head1 SYNOPSIS

Directly:

 use Convert::Color::Library;

 my $red = Convert::Color::Library->new( 'red' );

 # Only use the SVG dictionary
 my $brown = Convert::Color::Library->new( 'svg/brown' );

 # Use either HTML or SVG dictionary
 my $pink = Convert::Color::Library->new( 'html,svg/pink' );

Via L<Convert::Color>:

 use Convert::Color;

 my $cyan = Convert::Color->new( 'lib:cyan' );

 my $darkcyan = Convert::Color->new( 'lib:windows/darkcyan' );

=head1 DESCRIPTION

This subclass of L<Convert::Color::RGB8> provides lookup of color names
using Robert Krimen's L<Color::Library> module. It therefore provides
convenient access to named colours in many dictionaries, such as SVG, X11 and
HTML.

=cut

=head1 CONSTRUCTOR

=cut

=head2 $color = Convert::Color::Library->new( $name )

Returns a new object to represent the named color.

If the name is of the form

 dicts/name

Then C<dicts> is parsed as a comma-separated list of dictionary names to pass
to C<Color::Library>.

=cut

sub new
{
   my $class = shift;

   require Color::Library;

   if( @_ == 1 ) {
      my $name = $_[0];

      my $color;

      if( $name =~ m{^(.*)/(.*)$} ) {
         ( my $dicts, $name ) = ( $1, $2 );

         $color = Color::Library->color( [ split m/,/, $dicts ], $name );
      }
      else {
         $color = Color::Library->color( $name );
      }

      defined $color or croak "No such library color named '$name'";
      return $class->SUPER::new( $color->rgb );
   }
   else {
      croak "usage: Convert::Color::Library->new( NAME )";
   }
}

# Keep perl happy; keep Britain tidy
1;

__END__

=head1 TODO

=over 4

=item *

Consider an API for getting the list of dictionary names and colour names.
That said, it's easy enough to do directly to C<Color::Library>, so maybe not
needed.

=back

=head1 SEE ALSO

=over 4

=item *

L<Convert::Color> - color space conversions

=item *

L<Color::Library> - An easy-to-use and comprehensive named-color library

=back

=head1 AUTHOR

Paul Evans E<lt>leonerd@leonerd.org.ukE<gt>
