# Class: database
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

class database {
	include params
	if "$params::database" == "mysql" {
		include mysql
	} else {
		include sqlite
	}
}

class mysql {
	include params
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
			ensure	=>	installed,
	}
	package { "$mysqlserver":
			ensure	=>	installed,
	}
	package { "$mysqldevel":
			ensure	=>	installed,
	}
	service { "$servicename":
			ensure	=>	running,
			enable	=>	true,
			hasstatus	=>	true,
			hasrestart	=>	true,
	}
	Exec { path =>	"/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin" }
	exec { "Setmysql password":
			command		=>	"mysqladmin -u $params::mysqluser -p password $params::mysqlpassword",
			cwd			=>	"$params::tmpdir",
			require		=>	Service["$servicename"],
			}
	exec { "Create Database":
			command		=>	"mysqladmin -u $params::mysqluser -p$params::mysqlpassword create $params::mysqldbname",
			cwd			=>	"$params::tmpdir",
			require		=>	Exec["Setmysql password"],
	}		
}

class sqlite {
	case operatingsystem {
		centos, redhat: {
			$sqlite				=	"sqlite"
		}
		debian, ubuntu: {
			$sqlite				=	"sqlite"	
		}
	}
	package { "$sqlite":
		ensure	=>	installed,
	}
}

#class postgresql {
#	case $operatingsystem {
#		centos, redhat: {
#			$postgresql			=	"postgresql"
#			$postgresqlserver	=	"postgresql-server"
#			$postgresqldevel	=	"postgresql-devel"
#			$servicename		=	"postgresql"
#		}
#		debian, ubuntu:	{
#			$postgresql			=	"postgresql-client"
#			$postgresqlserver	=	"postgresql"
#			$postgresqldevel	=	"postgresql-server-dev"
#			$servicename		=	"postgresql"
#		}
#	}
#	package { "$postgresql":
#			ensure	=>	installed,
#	}
#	package { "$postgresqlserver":
#			ensure	=>	installed,
#	}
#	package	{ "$postgresqldevel":
#			ensure	=>	installed,
#	}
#	service { "$servicename":
#			ensure	=>	running,
#			enable	=>	true,
#			hasstatus	=>	true,
#			hasrestart	=>	true,
#	} 
#}

