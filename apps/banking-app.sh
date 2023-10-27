#!/bin/bash

python3.7 -m venv test
pip install gunicorn
pip install mysqlclient
source test/bin/activate
cd /home/ubuntu
git clone https://github.com/djtoler/Deployment6.git
cd Deployment6
pip install pip --upgrade
pip install -r requirements.txt
python database.py
sleep 1
python load_data.py
sleep 1 
python -m gunicorn app:app -b 0.0.0.0 -D && echo "Done"
