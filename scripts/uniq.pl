#!/usr/bin/perl -w

use strict;
use Getopt::Long;

###############################################################################
#
# Main program
#
###############################################################################

MAIN:
{
	my $i=0;
	my $max=1;

        my $result = GetOptions(
                "i=i"   => \$i,
		"max=i"	=> \$max
        );
	die "ERROR: $? " if (!$result);

	my %h;

	while(<>)
	{
		if(/^#/ or /^$/) { print }
		elsif(/^@/) { print }
		else
		{
			my @f=split;
			die if(!defined($f[$i]));

			$h{$f[$i]}++;
			print if($h{$f[$i]}<=$max);
		}
	}

	exit 0;
}
