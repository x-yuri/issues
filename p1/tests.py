import os
from base64 import b64decode, b64encode
import pickle

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
        self.handle_rnd_state(faker.generator.random, 'faker.state',
            'FAKER_RANDOM_STATE')
        self.handle_rnd_state(factory.random.randgen, 'factory.state',
            'FACTORY_RANDOM_STATE')
        super().setup_test_environment()

    def handle_rnd_state(self, rnd, fname, env_var):
        state = self.retrieve_rnd_state(fname, env_var)
        if state:
            rnd.setstate(state)
            # print('-- restored random state (%s)' % fname)
        else:
            self.store_rnd_state(fname, rnd.getstate())
            # print('-- saved random state (%s)' % fname)

    def retrieve_rnd_state(self, fname, env_var):
        state = os.environ.get(env_var)
        # state = None
        # try:
        #     with open(fname, 'r') as f:
        #         state = f.read()
        # except FileNotFoundError:
        #     pass
        return pickle.loads(b64decode(state.encode('ascii'))) if state else None

    def store_rnd_state(self, fname, state):
        encoded_state = b64encode(pickle.dumps(state))
        with open(fname, 'w') as f:
            f.write(encoded_state.decode('ascii'))
