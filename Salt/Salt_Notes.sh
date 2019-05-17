# FG:5/16/2019

###----- Salt Notes -----###

###----- Configuration file -----###
# https://docs.saltstack.com/en/latest/ref/configuration/master.html#interface
/etc/salt/master
# Add Formulas to file_roots

###----- Formulas -----###
/srv/formulas

###----- Add formula -----###
# Ex: Docker (https://github.com/saltstack-formulas)
cd /srv/formulas
git clone https://github.com/saltstack-formulas/docker-formula.git

###----- Apply Formula -----###
sudo salt 'SM*' state.apply docker