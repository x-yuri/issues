```
python -m venv env
. ./env/bin/activate
pip install -r requirements.txt
./manage.py migrate
```

```
$ ./manage.py test --testrunner p1.tests.MyTestRunner
Creating test database for alias 'default'...
.
----------------------------------------------------------------------
Ran 1 test in 0.017s

OK
Destroying test database for alias 'default'...
System check identified no issues (0 silenced).
-- 3, 5
-- 1, 4
-- 2, 5
-- 2, 4

$ FAKER_RANDOM_STATE=`cat faker.state` FACTORY_RANDOM_STATE=`cat factory.state` ./manage.py test --testrunner p1.tests.MyTestRunner
Creating test database for alias 'default'...
.
----------------------------------------------------------------------
Ran 1 test in 0.019s

OK
Destroying test database for alias 'default'...
System check identified no issues (0 silenced).
-- 3, 5
-- 1, 4
-- 2, 5
-- 2, 4
```

Test runner can be changed in the [settings][1].

[1]: https://docs.djangoproject.com/en/2.2/ref/settings/#test-runner
