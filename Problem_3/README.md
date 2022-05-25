# This is the Report and Results of Problem 3 (Docker)

### Description

As you can see, there is a code named "HTTP_Server.py" in this folder. This is the desired HTTP Server as the homework description wanted.

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

