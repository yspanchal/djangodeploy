# Class: params
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

class venv {
	include params
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
	exec { "Install virtualenv":
		command	=>	"pip-$params::python_version install virtualenv",
		cwd		=>	"$params::tempdir",
		before	=>	Exec["Create Virtualenv"],
	}
	exec { "Create Virtualenv":
		command	=>	"virtualenv $params::envpath$params::envname",
		cwd		=>	"$params::envpath",
		after	=>	Exec["Install virtualenv"],	
	}
	
}
