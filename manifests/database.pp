# Class: djangodeploy::database
#
# This module manages installing mysql or sqlite database
#
# Parameters:
#
# Actions: Install Mysql-Server
#		   Install Sqlite
#		   Create Mysql-Database
#
# Requires:
#
# Sample Usage:
#
# #############################################################################

class djangodeploy::database {
	include djangodeploy::params
	if "$djangodeploy::params::database" == "mysql" {
		include djangodeploy::mysql
	} elsif "$djangodeploy::params::database" == "sqlite" {
		include djangodeploy::sqlite
	} else {
		notify {"Error No database defined":}
	}
}

class djangodeploy::mysql {
	include djangodeploy::params
	case $operatingsystem {
		centos, redhat: {
			$mysql			=	"mysql"
			$mysqlserver	=	"mysql-server"
			$mysqldevel		=	"mysql-devel"
			$servicename	=	"mysqld"
		}
		debian, ubuntu: {
			$mysql			=	"mysql-client"
			$mysqlserver	=	"mysql-server"
			$mysqldevel		=	"libmysqlclient"
			$servicename	=	"mysql"
		}
	}
	package { "$mysql":
			ensure		=>	present,
	}
	package { "$mysqlserver":
			ensure		=>	installed,
	}
	package { "$mysqldevel":
			ensure		=>	installed,
	}
	service { "$servicename":
			ensure		=>	running,
			enable		=>	true,
			hasstatus	=>	true,
			hasrestart	=>	true,
	}
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
	exec { "Setmysql password":
			command		=>	"mysqladmin -u $djangodeploy::params::mysqluser -p password $djangodeploy::params::mysqlpassword",
			cwd			=>	"$djangodeploy::params::tmpdir",
			require		=>	Service["$servicename"],
			}
	exec { "Create Database":
			command		=>	"mysqladmin -u $djangodeploy::params::mysqluser -p$djangodeploy::params::mysqlpassword create $djangodeploy::params::mysqldbname",
			cwd			=>	"$djangodeploy::params::tmpdir",
			require		=>	Exec["Setmysql password"],
	}		
}

class djangodeploy::sqlite {
	case operatingsystem {
		centos, redhat: {
			$sqlite			=	"sqlite"
		}
		debian, ubuntu: {
			$sqlite			=	"sqlite"	
		}
	}
	package { "$sqlite":
		ensure		=>	installed,
	}
}