#!/usr/bin/perl

use Convert::Color::Library;

use Test::More tests => 6;

my $green = Convert::Color::Library->new( 'x11/green' );

is( $green->red,     0, 'x11/green red' );
is( $green->green, 255, 'x11/green green' );
is( $green->blue,    0, 'x11/green blue' );

$green = Convert::Color::Library->new( 'svg/green' );

is( $green->red,     0, 'svg/green red' );
is( $green->green, 128, 'svg/green green' );
is( $green->blue,    0, 'svg/green blue' );
