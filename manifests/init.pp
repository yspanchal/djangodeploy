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
#	Class["params"] -> Class["python"] -> Class["venv"] -> Class["app"] -> Class["database"] -> Class["apprun"]
#}
#
#node puppet {
#	include djangodeploy
#}
########################################################################################################################
#Customize Installation
#
#class djangodeploy {
#	Class["params"] -> Class["python"] -> Class["venv"] -> Class["app"] -> Class["apprun"]
#}
#
#
#node mysql.example.com {
#	include database
#}

#node puppet {
#	include djangodeploy
#}
########################################################################################################################