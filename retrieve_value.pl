#!/usr/bin/perl -w 
use LWP::Simple;
use WWW::Mechanize;
use HTML::TreeBuilder;

print "Visit https://my3.three.ie/ to log into system manually first"
#secure login for three.ie , Ireland. Works when dongle is plugged in, in Ubuntu.
my $url = 'https://my3.three.ie/';

my $mech = WWW::Mechanize->new();
$mech->agent_alias( 'Linux Mozilla' );
$mech->get( $url );

# follow first link(logged in now)
$mech->follow_link( n => 1 );

# view account information
$mech->submit_form(
	form_number => 1
);

my $tree = HTML::TreeBuilder->new_from_content($mech->content);

# extract the remaining Mbs left. Stored within tds
foreach my $td ($tree->look_down(_tag => 'td')) {
	$in_cell = $td->as_text;

	# only get the actual value, discard everything else
	if($in_cell =~ m/,/) {  
	    print $in_cell . "\n";
	}
}
