# Class: djangodeploy
#
# This module manages django-deploy
#
# Parameters:
#
# Actions: Deploy Django Application
#
# Requires:
#
# Sample Usage: Following is sample usage of classes for deploying django application
#
# 
#class djangodeploy {
#	Class["djangodeploy::params"] -> Class["djangodeploy::python"] -> Class["djangodeploy::venv"] -> Class["djangodeploy::app"] -> Class["djangodeploy::database"] -> Class["djangodeploy::apprun"]
#}
#
#node puppet {
#	include djangodeploy
#}
########################################################################################################################
#Customize Installation
#
#class djangodeploy {
#	Class["djangodeploy::params"] -> Class["djangodeploy::python"] -> Class["djangodeploy::venv"] -> Class["djangodeploy::app"] -> Class["djangodeploy::apprun"]
#}
#
#
#node mysql.example.com {
#	include djangodeploy::database
#}

#node puppet {
#	include djangodeploy
#}
########################################################################################################################

