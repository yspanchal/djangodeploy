# Class: djangodeploy::python
#
# This module manages python, pip & its dependencies installation
#
# Parameters:
#
# Actions: Install python
#		   Install pip
#
# Requires:
#
# Sample Usage:
#
# #########################################################################


class djangodeploy::python {
	include djangodeploy::params
	if $python_version == "$djangodeploy::params::pythonversion" {
		notify { 'Current python version is OK': }
		if $pip_version1 == "$djangodeploy::params::pythonversion" or $pip_version2 == "$djangodeploy::params::pythonversion" {
			notify { "Current pip version is OK": }
		} else {
			include djangodeploy::pipinstall
		}
	} else {
		include djangodeploy::install
		include djangodeploy::setuptools
		include djangodeploy::pipinstall
	}
}

class djangodeploy::install {
	include djangodeploy::params
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
    file { ["$djangodeploy::params::prefix", "$djangodeploy::params::tmpdir"]: ensure => directory }
    exec { "Download-python-$djangodeploy::params::pythonversion":
    	command	=>	"wget http://python.org/ftp/python/$djangodeploy::params::pythonversion/Python-$djangodeploy::params::pythonversion.tgz",
    	cwd		=>	"$djangodeploy::params::tmpdir",
    	before	=>	Exec["Extract-python-$djangodeploy::params::pythonversion"]
    }
    exec { "Extract-python-$djangodeploy::params::pythonversion":
    	command	=>	"tar -zxvf Python-$djangodeploy::params::pythonversion.tgz",
    	cwd		=>	"$djangodeploy::params::tmpdir",
    	require	=>	Exec["Download-python-$djangodeploy::params::pythonversion"],
    	before	=>	Exec["Configure-python-$djangodeploy::params::pythonversion"],
    }
    exec { "Configure-python-$djangodeploy::params::pythonversion":
    	command	=>	"$djangodeploy::params::tmpdir/Python-$djangodeploy::params::pythonversion/configure",
    	cwd		=>	"$djangodeploy::params::tmpdir",
    	require	=>	Exec["Extract-python-$djangodeploy::params::pythonversion"],
    	before	=>	Exec["Compile-python-$djangodeploy::params::pythonversion"],
    }
    exec { "Compile-python-$djangodeploy::params::pythonversion":
    	command	=>	"make",
    	cwd		=>	"$djangodeploy::params::tmpdir/Python-$djangodeploy::params::pythonversion/",
    	require	=>	Exec["Configure-python-$djangodeploy::params::pythonversion"],
    	before	=>	Exec["Install-python-$djangodeploy::params::pythonversion"],
    }
    exec { "Install-python-$djangodeploy::params::pythonversion":
    	command	=>	"make install",
    	cwd		=>	"$djangodeploy::params::tmpdir/Python-$djangodeploy::params::pythonversion/",
    	require	=>	Exec["Compile-python-$djangodeploy::params::pythonversion"],
    }
}

class djangodeploy::setuptools {
	include djangodeploy::params
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
	exec { "Download-setuptools":
		command	=>	"wget http://python-distribute.org/distribute_setup.py",
		cwd		=>	"$djangodeploy::params::tmpdir",
		require	=>	File["$djangodeploy::params::prefix", "$djangodeploy::params::tmpdir"],
		before	=>	Exec["Install-setuptools"],
	}
	exec { "Install-setuptools":
		command	=>	"python$djangodeploy::params::pythonversion distribute_setup.py",
		cwd		=>	"$djangodeploy::params::tmpdir",
		require	=>	Exec["Download-setuptools"],
	}
}

class djangodeploy::pipinstall { 
	include djangodeploy::params
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
	exec { "Download-pip":
		command	=>	"wget http://pypi.python.org/packages/source/p/pip/pip-$djangodeploy::params::pipversion.tar.gz",
		cwd		=>	"$djangodeploy::params::tmpdir",
		require	=>	File["$djangodeploy::params::prefix", "$djangodeploy::params::tmpdir"],
		before	=>	Exec["Extract-pip"],
	}
	exec { "Extract-pip":
		command	=>	"tar -zxvf pip-$djangodeploy::params::pipversion.tar.gz",
		cwd		=>	"$djangodeploy::params::tmpdir",
		require	=>	Exec["Download-pip"],
		before	=>	Exec["Install-pip"],
	}
	exec { "Install-pip":
		command	=>	"python$djangodeploy::params::pythonversion setup.py install",
		cwd		=>	"$djangodeploy::params::tmpdir/pip-$djangodeploy::params::pipversion/",
		require	=>	Exec["Extract-pip"],
	}
}