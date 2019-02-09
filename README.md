	$ python -m venv env
	$ . env/bin/activate
	$ pip install -r requirements.txt
	$ python manage.py migrate
	$ python manage.py createsuperuser --username u1 --email u1@gmail.com
	$ python manage.py runserver localhost:9000 &
	$ yarn
	$ ./node_modules/.bin/cypress open
	// run with Developers Tools open
