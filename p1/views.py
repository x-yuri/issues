import time
from django.http import HttpResponse
from django.views.generic import TemplateView
from django.utils.decorators import method_decorator
from django.views.decorators.csrf import ensure_csrf_cookie
from django.contrib.auth import login as auth_login
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_exempt

class OrderView(TemplateView):
    template_name = 'p1/order.html'

    @method_decorator(ensure_csrf_cookie)
    def get(self, request):
        request.session.setdefault('a', 1);
        return super().get(request)

    def post(self, request):
        request.session['a'] += 1
        time.sleep(1)
        return HttpResponse(204)

@csrf_exempt
def login(request):
    user = User.objects.first()
    auth_login(request, user, backend='django.contrib.auth.backends.ModelBackend')
    return HttpResponse(204)
