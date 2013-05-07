# Class: djangodeploy::app
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

class djangodeploy::app {
	include djangodeploy::params
	if $djangodeploy::params::git == "Enable" {
		include djangodeploy::git
	} elsif $djangodeploy::params::svn == "Enable" {
		include djangodeploy::svn
	} else {
	notify { "No application repo defined $params::git $params::svn ": }
	}
}

class djangodeploy::git {
	include djangodeploy::params
	package { "git":
		ensure		=>	installed,
	}
	exec { "git clone":
		command		=>	"git clone $djangodeploy::params::gitrepo",
		cwd			=>	"$djangodeploy::params::envpath",
		require		=>	Package["git"],
	}
}

class djangodeploy::svn {
	include	djangodeploy::params
	package	{ "subversion":
		ensure		=>	installed,
		before		=>	Exec["svn checkout"],
	}
	if $djangodeploy::params::svnuser == '' and $djangodeploy::params::svnpassword == '' {
		$svncommand = "svn co $djangodeploy::params::svnrepo"
	} else {
		$svncommand = "svn co --username $djangodeploy::params::svnuser --password $djangodeploy::params::svnpassword $djangodeploy::params::svnrepo"
	}
	notify { "Current SVN command is $svncommand": }
	exec { "svn checkout":
		command		=>	"$svncommand",
		cwd			=>	"$djangodeploy::params::envpath",
		require		=>	Package["subversion"],
	}
}