# INSTALL 1 IF ERROR OCCURS
sudo apt-get update
sudo apt-get install python3-dev python3.4-venv 
python3 -m venv env
env/bin/python -m pip install --upgrade pip setuptools
source env/bin/activate
python -m pip install --upgrade google-assistant-library
python -m pip install --upgrade google-auth-oauthlib[tool]