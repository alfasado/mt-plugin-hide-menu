package HideMenu::Plugin;

use strict;

sub _pre_run {
    my $app = MT->instance;
    my $blog = $app->blog;
    my $current_scope = 'system';
    if ( $blog ) {
        $current_scope = $blog->class;
    }
    my $core = MT->component( 'core' );
    my $cr = $core->registry( 'applications', 'cms', 'menus' );
    my $hidemenu = $app->config( 'HideMenus' );
    my @memus = split( /,/, $hidemenu );
    for my $menu ( @memus ) {
        if (! $app->blog ) {
            $cr->{ $menu } = { view => [ 'blog' ] };
        } else {
            if ( exists $cr->{ $menu }->{ view } ) {
                $cr->{ $menu }->{ view } = ( $current_scope eq 'blog' ) ? 'website' : 'blog';
            }
        }
    }
    return 1;
}

1;