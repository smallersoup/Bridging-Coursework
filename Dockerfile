FROM python:3.7-alpine

WORKDIR /app

COPY . .

RUN python -V \
&& python -m pip install django \
&& python -m pip install markdown \
&& python -m django --version \
&& python -m markdown --version

ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]