# Class: djangodeploy::apprun
#
# This module manages creating database & running application
#
# Parameters:
#
# Actions:	python manage.py syncdb
#		    python manage.py runserver 0.0.0.0:8000
#
# Requires:
#
# Sample Usage:
#
# #############################################################################

class djangodeploy::apprun {
	include djangodeploy::params
	exec { "Syncdb":
		command		=>	"$djangodeploy::params::envpath$djangodeploy::params::envname/bin/python $djangodeploy::params::envpath$djangodeploy::params::managefilepath/manage.py syncdb --noinput",
		cwd			=>	"$djangodeploy::params::envpath$djangodeploy::params::managefilepath",
	}
	exec { "runapp":
		command		=>	"$djangodeploy::params::envpath/bin/python $djangodeploy::params::envpath$djangodeploy::params::managefilepath/manage.py runserver 0.0.0.0:8000 &",
		cwd			=>	"$djangodeploy::params::envpath$djangodeploy::params::managefilepath",
	}
}