# automation-collection

1) To create a Child service principal dynamically using master service principal. This will create child app, sp and grab a new token from child sp.

Follow these steps:

Clone this repo.
Tested with python version - Python 3.9.18
Create a virtual env and ensure that the modules in requirements.txt are installed using pip install cli.
Activate the virtualenv : source /opt/virtualenvs/k8s/bin/activate
Run the ansible playbook : ansible-playbook all-rest-app-sp.yml --extra-vars "GUID=$GUID"
