# Class: venv
#
# This module manages installing & creating python virtual environment 
#
# Parameters:
#
# Actions: Install Virtual Env
#		   Create Virtual Env
#		   Install Python Packages
#
# Requires:
#
# Sample Usage:
#
# #########################################################################

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
		require	=>	Exec["Install virtualenv"],	
	}
	file { "$params::envpath/requirements.txt":
		ensure	=>	"present",
		content	=>	template("djangodeploy/requirements.txt.erb"),
		require	=>	"Create Virtualenv",
	}
	exec { "Install-packages":
		command	=>	"$params::envpath/$params::envname/bin/pip-$params::pythonversion install -r requirements.txt",
		cwd	=>	"$params::envpath",
		require	=>	"Install-packages",
	}
}
