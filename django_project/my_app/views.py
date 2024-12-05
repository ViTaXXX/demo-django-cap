from django.shortcuts import HttpResponse

def index(request):
    return HttpResponse("<h1>Hello World, Django de Andres.</h1>")
