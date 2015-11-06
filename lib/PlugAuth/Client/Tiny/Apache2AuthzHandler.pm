package PlugAuth::Client::Tiny::Apache2AuthzHandler;

use strict;
use warnings;
use 5.012;
use PlugAuth::Client::Tiny;
use Apache2::Access      ();
use Apache2::RequestUtil ();
use Apache2::Const -compile => qw(OK HTTP_UNAUTHORIZED);

# ABSTRACT: Apache authorization handler for PlugAuth
# VERSION

=head1 SYNOPSIS

In your httpd.conf:

 <Location /protected>
   PerlAuthenHandler PlugAuth::Client::Tiny::Apache2AuthenHandler
   PerlAuthzHandler  PlugAuth::Client::Tiny::Apache2AuthzHandler
   AuthType Basic
   AuthName "My Protected Documents"
   Require valid-user
   PerlSetEnv PLUGAUTH_URL http://localhost:3001
 </Location>

=head1 DESCRIPTION

=head1 SEE ALSO

=over 4

=item L<PlugAuth::Client::Tiny::Apache2AuthenHandler>

For authentication.

=item L<PlugAuth>

Server to authenticate against.

=item L<PlugAuth::Client::Tiny>

Simplified PlugAuth client.

=item L<Alien::Apache24|https://github.com/plicease/Alien-Apache24>

For testing

=back

=cut

sub handler
{
  my($r) = @_;
  
  my $auth   = PlugAuth::Client::Tiny->new(url => $ENV{PLUGAUTH_URL});
  my $prefix = $ENV{PLUGAUTH_PREFIX} // '';
  
  my $user = $r->user;
  if($user && $auth->authz($user, $r->method, $prefix . $r->uri))
  {
    return Apache2::Const::OK;
  }
  else
  {
    $r->note_basic_auth_failure;
    return Apache2::Const::HTTP_UNAUTHORIZED;
  }
}

1;
