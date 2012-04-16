package HideMenu::Plugin;

use strict;

sub _pre_run {
    my $app = MT->instance;
    my $core = MT->component( 'core' );
    my $cr = $core->registry( 'applications', 'cms', 'menus' );
    my $hidemenu = $app->config( 'HideMenus' );
    my @memus = split( /,/, $hidemenu );
    for my $menu ( @memus ) {
        if (! $app->blog ) {
            $cr->{ $menu } = { view => [ 'blog' ] };
        } else {
            $cr->{ $menu } = {};
        }
    }
    return 1;
}

1;