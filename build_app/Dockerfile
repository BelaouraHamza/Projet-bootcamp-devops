FROM python:3.6-alpine
LABEL maintainer="Hamza BLR"
WORKDIR /opt
RUN pip install flask==1.1.2 --index-url=https://pypi.org/simple
COPY . /opt/
EXPOSE 8080
ENV ODOO_URL="https://www.odoo.com/"
ENV PGADMIN_URL="https://www.pgadmin.org/"
ENTRYPOINT [ "python", "app.py" ]
