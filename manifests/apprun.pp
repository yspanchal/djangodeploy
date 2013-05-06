# Class: app
#
# This module manages django-deploy
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]

class apprun {
	include params
	exec { "Syncdb":
		command		=>	"$params::envpath$params::envname/bin/python $params::envpath$params::managefilepath/manage.py syncdb --noinput",
		cwd			=>	"$params::envpath$params::managefilepath",
	}
	exec { "runapp":
		command		=>	"$params::envpath/bin/python $params::envpath$params::managefilepath/manage.py runserver 0.0.0.0:8000 &",
		cwd			=>	"$params::envpath$params::managefilepath",
	}
}