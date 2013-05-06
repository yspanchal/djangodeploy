# Class: djangodeploy
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

class djangodeploy {
	include database
}

node puppet {
	include djangodeploy
}