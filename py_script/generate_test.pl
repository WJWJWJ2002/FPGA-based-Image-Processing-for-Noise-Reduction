use strict;
use warnings;
use Statistics::Basic qw(:all);
my ($i, $j, $k);
my @num;
my $median;
my $rand_num;
my $txtfile = '/mnt/c/Users/HP/Desktop/Median Filter/test_case.txt';
open(my $file, '>', $txtfile) or die "Cannot open text file '$txtfile' $!";
for ($i = 1; $i <= 500; $i = $i + 1) 
{
	print $file "\t\t9'd$i: begin\n";
	for ($j=1; $j < 10; $j = $j + 1 ) 
	{
		$rand_num = int(rand(256));
		push @num, $rand_num;
		print $file "\t\t\tp$j <= 8'd$rand_num;\n";
	}
	
	$median = median($num[0], $num[1], $num[2], $num[3], $num[4], $num[5], $num[6], $num[7], $num[8]);
	print $file "\t\t\ttrue_med <= 8'd$median;\n\n";
	for ($k = 0; $k < 9; $k = $k + 1) 
	{
		pop(@num);
	}
	print $file "\t\tend\n"
}
print $file "\t\tdefault: begin\n";
print $file "\t\t\ttrue_med <= true_med;\n";
print $file "\t\t\tdone_sim <= 1'b1;\n";
print $file "\t\tend\n";
print $file "\tendcase\n";
close $file;
print "done\n";
