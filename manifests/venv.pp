# Class: djangodeploy::venv
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

class djangodeploy::venv {
	include djangodeploy::params
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
	exec { "Install virtualenv":
		command	=>	"pip-$djangodeploy::params::python_version install virtualenv",
		cwd		=>	"$djangodeploy::params::tempdir",
		before	=>	Exec["Create Virtualenv"],
	}
	exec { "Create Virtualenv":
		command	=>	"virtualenv $djangodeploy::params::envpath$djangodeploy::params::envname",
		cwd		=>	"$djangodeploy::params::envpath",
		require	=>	Exec["Install virtualenv"],	
	}
	file { "$djangodeploy::params::envpath/requirements.txt":
		ensure	=>	"present",
		content	=>	template("djangodeploy/requirements.txt.erb"),
		require	=>	"Create Virtualenv",
	}
	exec { "Install-packages":
		command	=>	"$djangodeploy::params::envpath/$djangodeploy::params::envname/bin/pip-$djangodeploy::params::pythonversion install -r requirements.txt",
		cwd		=>	"$djangodeploy::params::envpath",
		require	=>	"Install-packages",
	}
}
