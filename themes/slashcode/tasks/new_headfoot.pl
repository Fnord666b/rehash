#!/usr/bin/perl -w

use strict;
use Slash;
use File::Path;

use vars qw( %task $me );

$task{$me}{timespec} = '3,33 * * * *';
$task{$me}{on_startup} = 1;
$task{$me}{code} = sub {
	my($virtual_user, $constants, $slashdb, $user) = @_;

	# shouldn't be necessary, since sectionHeaders() restores STDOUT before
	# exiting
	local *SO = *STDOUT;

	sectionHeaders(@_, "");
	my $sections = $slashdb->getSections();
	for (keys %$sections) {
		my($section) = $sections->{$_}{section};
		mkpath "$constants->{basedir}/$section", 0, 0755;
		sectionHeaders(@_, $section);
	}

	*STDOUT = *SO;

	return ;
};

sub sectionHeaders {
	my($virtual_user, $constants, $slashdb, $user, $section) = @_;

	my $form = getCurrentForm();
	local(*STDOUT);

	setCurrentForm('ssi', 1);
	my $fh = gensym();
	open $fh, ">$constants->{basedir}/$section/slashhead.inc"
		or die "Can't open $constants->{basedir}/$section/slashhead.inc: $!";
	*STDOUT = $fh;
	header("", $section, "thread", 1);
	close $fh;

	setCurrentForm('ssi', 0);
	open $fh, ">$constants->{basedir}/$section/slashfoot.inc"
		or die "Can't open $constants->{basedir}/$section/slashfoot.inc: $!";
	*STDOUT = $fh;
	footer();
	close $fh;
}

1;

