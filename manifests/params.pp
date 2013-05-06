# Class: params
#
# This module manages parameters used to setup application
#
# Parameters: 
#				
#`	$pythonversion		=>	required python version to install
#	$tmpdir				=>	path to temp directory
#	$prefix				=>	path to installation
#	$pipversion			=>	pip version to install
#	$envpath			=>	path to virtual env
#	$envname			=>	virtual env name
#	$git				=>	Enable git repo Options: "Enable" or "Disbale"
#	$gitrepo			=>	git repository url Ex: https://github.com/yspanchal/djangodeploy.git
#	$svn				=>	Enable SVN if you dont want to use git.  Options: "Enable" or "Disable"
#	$svnrepo			=>	svn repository url Ex: 
#	$svnuser			=>	svn repo username if required
#	$svnpassword		=>	svn repo password
#	$database			=>	Django application database [Only Mysql & Sqlite is supported]
#	$mysqluser			=>	Mysqlusername "root"
#	$mysqlpassword		=>	Mysqlpassword "password"
#	$mysqldbname		=>	Mysql database name
#	$$managefilepath	=>	Path to manage.py file For Ex: myproject/webapp
#					
# Actions:
#
# Requires:
#
# Sample Usage:
#
# #############################################################################

class params {
	$pythonversion = "2.6"
	$tmpdir = "/tmp"
	$prefix = "/usr/local"
	$pipversion = "1.3"
	$envpath = "/var/www/"
	$envname = "testproject"
	$git = "Enable"
	$gitrepo = "http://gitrepo"
	$svn = ""
	$svnrepo = "http://svnrepo"
	$svnuser = ""
	$svnpassword = ""
	$database = "mysql"
	$mysqluser = "root"
	$mysqlpassword = "password"
	$mysqldbname = "myproject"
	$managefilepath = "myproject/webapp"
	
}
