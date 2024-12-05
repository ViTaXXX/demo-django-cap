#!/bin/sh

python manage.py collectstatic --noinput

python manage.py migrate

## Superusuario automaticamente de prueba sin entrar al contenedor:

python manage.py shell << END
from django.contrib.auth import get_user_model
import os

User = get_user_model()

USERNAME = os.getenv("DJANGO_SUPERUSER_USERNAME", "admin")
EMAIL = os.getenv("DJANGO_SUPERUSER_EMAIL", "admin@example.com")
PASSWORD = os.getenv("DJANGO_SUPERUSER_PASSWORD", "admin")

if not User.objects.filter(username=USERNAME).exists():
    User.objects.create_superuser(USERNAME, EMAIL, PASSWORD)
    print(f"Superusuario '{USERNAME}' creado con éxito.")
else:
    print(f"El superusuario '{USERNAME}' ya existe elige otro nombre.")
END


gunicorn django_project.wsgi --bind=0.0.0.0:80

