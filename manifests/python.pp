# Class: python
#
# This module manages python installation
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
#node puppet {
#	include venv
#}

class python {
	include params
	if $python_version == "$params::pythonversion" {
		notify { 'Current python version is OK': }
		if $pip_version1 == "$params::pythonversion" or $pip_version2 == "$params::pythonversion" {
			notify { "Current pip version is OK": }
		} else {
			include pipinstall
		}
	} else {
		include install
		include setuptools
		include pipinstall
	}
}

class install {
	include params
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
    file { ["$params::prefix", "$params::tmpdir"]: ensure => directory }
    exec { "Download-python-$params::pythonversion":
    	command	=>	"wget http://python.org/ftp/python/$params::pythonversion/Python-$params::pythonversion.tgz",
    	cwd	=>	"$params::tmpdir",
    	before	=>	Exec["Extract-python-$params::pythonversion"]
    }
    exec { "Extract-python-$params::pythonversion":
    	command	=>	"tar -zxvf Python-$params::pythonversion.tgz",
    	cwd	=>	"$params::tmpdir",
    	require	=>	Exec["Download-python-$params::pythonversion"],
    	before	=>	Exec["Configure-python-$params::pythonversion"],
    }
    exec { "Configure-python-$params::pythonversion":
    	command	=>	"$params::tmpdir/Python-$params::pythonversion/configure",
    	cwd	=>	"$params::tmpdir",
    	require	=>	Exec["Extract-python-$params::pythonversion"],
    	before	=>	Exec["Compile-python-$params::pythonversion"],
    }
    exec { "Compile-python-$params::pythonversion":
    	command	=>	"make",
    	cwd	=>	"$params::tmpdir/Python-$params::pythonversion/",
    	require	=>	Exec["Configure-python-$params::pythonversion"],
    	before	=>	Exec["Install-python-$params::pythonversion"],
    }
    exec { "Install-python-$params::pythonversion":
    	command	=>	"make install",
    	cwd	=>	"$params::tmpdir/Python-$params::pythonversion/",
    	require	=>	Exec["Compile-python-$params::pythonversion"],
    }
}

class setuptools {
	include params
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
	exec { "Download-setuptools":
		command	=>	"wget http://python-distribute.org/distribute_setup.py",
		cwd	=>	"$params::tmpdir",
		require	=>	File["$params::prefix", "$params::tmpdir"],
		before	=>	Exec["Install-setuptools"],
	}
	exec { "Install-setuptools":
		command	=>	"python$params::pythonversion distribute_setup.py",
		cwd	=>	"$params::tmpdir",
		require	=>	Exec["Download-setuptools"],
	}
}

class pipinstall { 
	include params
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
	exec { "Download-pip":
		command	=>	"wget http://pypi.python.org/packages/source/p/pip/pip-$params::pipversion.tar.gz",
		cwd	=>	"$params::tmpdir",
		require	=>	File["$params::prefix", "$params::tmpdir"],
		before	=>	Exec["Extract-pip"],
	}
	exec { "Extract-pip":
		command	=>	"tar -zxvf pip-$params::pipversion.tar.gz",
		cwd	=>	"$params::tmpdir",
		require	=>	Exec["Download-pip"],
		before	=>	Exec["Install-pip"],
	}
	exec { "Install-pip":
		command	=>	"python$params::pythonversion setup.py install",
		cwd	=>	"$params::tmpdir/pip-$params::pipversion/",
		require	=>	Exec["Extract-pip"],
	}
}