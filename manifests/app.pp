# Class: app
#
# This module manages pulling application from git or svn repository
#
# Parameters:
#
# Actions: Git clone 
#		   SVN checkout
#
# Requires:
#
# Sample Usage:
#
# #########################################################################

class app {
	include params
	if $params::git == "Enable" {
		include git
	} elsif $params::svn == "Enable" {
		include svn
	} else {
	notify { "No application repo defined $params::git $params::svn ": }
	}
}

class git {
	include params
	package { "git":
		ensure	=>	installed,
	}
	exec { "git clone":
		command	=>	"git clone $params::gitrepo",
		cwd	=>	"$params::envpath",
		require	=>	Package["git"],
	}
}

class svn {
	include	params
	package	{ "subversion":
		ensure	=>	installed,
		before	=>	Exec["svn checkout"],
	}
	if $params::svnuser == '' and $params::svnpassword == '' {
		$svncommand = "svn co $params::svnrepo"
	} else {
		$svncommand = "svn co --username $params::svnuser --password $params::svnpassword $params::svnrepo"
	}
	notify { "Current SVN command is $svncommand": }
	exec { "svn checkout":
		command	=>	"$svncommand",
		cwd	=>	"$params::envpath",
		require	=>	Package["subversion"],
	}
}