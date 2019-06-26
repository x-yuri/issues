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
-- seed: IPnHCxdWehAxz6ctbNvyPQ==
System check identified no issues (0 silenced).
-- 1, 5
-- 1, 5
-- 3, 4
-- 3, 6

$ FACTORY_SEED=IPnHCxdWehAxz6ctbNvyPQ== ./manage.py test --testrunner p1.tests.MyTestRunner
Creating test database for alias 'default'...
.
----------------------------------------------------------------------
Ran 1 test in 0.017s

OK
Destroying test database for alias 'default'...
-- seed: IPnHCxdWehAxz6ctbNvyPQ==
System check identified no issues (0 silenced).
-- 1, 5
-- 1, 5
-- 3, 4
-- 3, 6
```

Test runner can be changed in the [settings][1].

[1]: https://docs.djangoproject.com/en/2.2/ref/settings/#test-runner
