# This is the Report and Results of Problem 3 (Docker)

### Description
This is the guide and report for SDMN homework 2, problem 3. Please read it very carefully.

## "HTTP_Server.py" code
### Running and Testing the Code
As you can see, there is a code named "HTTP_Server.py" in the "Python_Code" directory. This is the desired HTTP Server as the homework description wanted. You can run this code on your system with python3.8. Note that the existance of the "api" directory is mandatory for code to run properly. In the next section we will discuss about dockerizing the code. Now we focus on running the code on our main system (OS).

There is a .json file in the path "/api/v1/status/status.json". This .json file is responded when a GET request is sent to the server. Also the data of the POST request is written in the mentioned .json file. 

There are some important notes to use the code. Before testing the code, please pay attention to below notes.

I tested the GET request in this format and it worked:

	curl -X GET localhost:8000/api/v1/status
    
Additionally you can use the full path like this:

	curl -X GET localhost:8000/api/v1/status/status.json

Also I tested the POST request in this format and it worked:

	curl -X POST --data '{ "status": "not OK" }' localhost:8000/api/v1/status
    
Additionally you can use the full path like this:

	curl -X POST --data '{ "status": "not OK" }' localhost:8000/api/v1/status/status.json
    
### Results

Below screenshot shows the execution of GET and POST requests and their responses:

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_3/Results/01.png?raw=true)


Below screenshot shows the HTTP server logs after receiving GET and POST requests:

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_3/Results/02.png?raw=true)


## Dockerizing the Code

### Pulling the Image form my docker-hub account 

Please refer to the "Docker_Files" directory. In this directory we have the "Dockerfile", the python code and the api directory. We will build an image using the "Dockerfile". Note that we used python:3.8-slim to reduce the image size. Also note that I pushed the image to my docker-hub account. You can pull the image using this command:

	docker pull armanma79/sdmn_hw02:p3_http_server
	
After pulling the image, you can run it using this command:

	docker run -p 8000:8000 armanma79/sdmn_hw02:p3_http_server

Note that the maping of the ports is very important. If you don't do the mapping, the os can NOT find our Web Server on localhost. 

### Building the image using "Dockerfile" 

Another way to run the image on your computer is to build it on your own. To do so, build the image using the "Dockerfile" which is in the "Docker_Files" directory of this repo. Then you have to run the built image. 

### Results

I provided some screenshots of building, pushing (the image to my docker-hub) and running of the image. Then I tested the Web Server by sending some requests.

Below screenshot shows the procedure of building, pushing and running the image. Also the log of the image is visible:

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_3/Results/04.png?raw=true)

Below screenshot shows the execution of GET and POST requests and their responses. Note that this screenshot is related to the logs of the previous screenshot:

![alt text](https://github.com/arman-maghsoudnia/SDMN_HW02/blob/main/Problem_3/Results/03.png?raw=true)

