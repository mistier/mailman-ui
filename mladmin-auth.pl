#!/usr/local/bin/perl

$| = 1;
while(<STDIN>){

  my $ldap_host = "ldap.example.com";
  my $base_dn   = "dc=example,dc=com";

  chop;
  my ($uri,$user)=split /:/;

  $uri =~ s/^.*admin\///g;
  $uri =~ s/^.*admindb\///g;
  $uri =~ s/^.*confirm\///g;
  $uri =~ s/^.*create\///g;
  $uri =~ s/^.*subscribe\///g;
  $uri =~ s/^.*roster\///g;
  $uri =~ s/^.*private\///g;
  $uri =~ s/^.*options\///g;
  $uri =~ s/^.*listinfo\///g;
  $uri =~ s/\/.*$//g;
  my $flag = "0";

  open AUTHZ, "/usr/local/bin/ldapsearch -h $ldap_host -b \"$base_dn\" -x uid=$user | /usr/bin/grep ^title: | /usr/bin/grep $uri | /usr/bin/wc -l |";
  my $authz = <AUTHZ>;

  open MAILMAN, "/usr/local/bin/ldapsearch -h $ldap_host -b \"$base_dn\" -x uid=$user | /usr/bin/grep ^title: | /usr/bin/grep mailman | /usr/bin/wc -l |";
  my $mailman = <MAILMAN>;

  if($authz > 0 or $mailman > 0) {
    print "ok\n";
  }
  else {
    print "ng\n";
  }

}
