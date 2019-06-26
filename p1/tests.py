import os
from base64 import b64encode

from django.test import TestCase
import factory.random, factory.fuzzy
import faker.generator
from django.test.runner import DiscoverRunner

class MyModel:
    def __init__(self, *args, **kwargs):
        for k, v in kwargs.items():
            setattr(self, k, v)

class MyModelFactory(factory.Factory):
    class Meta:
        model = MyModel
    a1 = factory.Faker('random_element', elements=['1', '2', '3'])
    a2 = factory.fuzzy.FuzzyChoice(['4', '5', '6'])

class TC1(TestCase):
    def test_t1(self):
        m = MyModelFactory(); print('-- {}, {}'.format(m.a1, m.a2))
        m = MyModelFactory(); print('-- {}, {}'.format(m.a1, m.a2))
        m = MyModelFactory(); print('-- {}, {}'.format(m.a1, m.a2))
        m = MyModelFactory(); print('-- {}, {}'.format(m.a1, m.a2))

class MyTestRunner(DiscoverRunner):
    def setup_test_environment(self):
        seed = os.environ.get('FACTORY_SEED')
        if seed:
            seed = seed.encode('ascii')
        if not seed:
            seed = b64encode(os.urandom(16))
        print('-- seed: %s' % seed.decode('ascii'))
        factory.random.reseed_random(seed)
        super().setup_test_environment()
