#!/bin/bash

echo "-------------"
echo "Creating /tempdir and subdirectories /tempdir/templates & /tempdir/static"
sudo mkdir /tempdir
sudo mkdir /tempdir/templates
sudo mkdir /tempdir/static
echo "Directory & subdirectories created"
echo "-------------"
echo "Copying files into /tempdir/templates & /tempdir/static..."
sudo cp -r ./static/. /tempdir/templates/
sudo cp -r ./templates/. /tempdir/static/
sudo cp ./desafio2_app.py /tempdir/
echo "Files copied to mentioned directories.."
echo "-------------"
echo "Creating DockerFile..."
sudo touch /tempdir/Dockerfile
sudo chmod 666 /tempdir/Dockerfile
sudo cat << EOF >> /tempdir/Dockerfile
FROM python
RUN pip install flask
COPY ./static /home/myapp/static
COPY ./templates /home/myapp/templates
COPY desafio2_app.py /home/myapp/
EXPOSE 5050
CMD python3 /home/myapp/desafio2_app.py
EOF
echo "Docker file created, showing its content.."
cat /tempdir/Dockerfile
echo "-------------"
echo "Building app..."
cd /tempdir/
sudo docker build -t desafio2app:1.0 .
echo "Running app..."
sudo docker run -t -d -p 5050:5050 --name desafio2apprunning desafio2app:1.0
echo "Showing docker containers..."
sudo docker ps -a
