#!/bin/bash

python3.7 -m venv test
source test/bin/activate
pip install pip --upgrade
pip install -r requirements.txt
pip install gunicorn
python database.py
sleep 1
python load_data.py
sleep 1 
python -m gunicorn app:app -b 0.0.0.0 -D && echo "Done"
