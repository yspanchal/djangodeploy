djangodeploy
============

Puppet Script to Deploy Django Application


<-djangodeploy->

This is the module to deploy django application using git or svn repo & mysql or sqlite database.

Steps:

=> Setup Variables in params.pp file according to your requirements.

=> Copy - Paste your requirements.txt in templates/requirements.txt.erb

=> This script supports mysql & sqlite database setup. [Currently no postgresql supported]

=> This script supports git or svn repo checkout for application code.

=> Example usage given in init.pp
