# README

Problem statement:

Design a state framework for managing service interrupts.


Service to Build:  Data Uploader Service


Requirements:

1. Upload - Should read the data and start uploading the data into Database
2. Stop   - Should stop the file upload and rollback to original state
3. Kill   - Should kill the file upload process and maintain its last know state


Technologies Used
Language  - Ruby
Framework - Rails
Database  - Postgresql
Infra     - Docker

DB Models:
1. file_tracker (id, status) - to track file and its status
2. file_data(file_tracker_id, name, email, created_at, updated_at) - to store the data of the file

DB Association:

file_tracker has many file_data
file_data belongs to file_tracker

Workflow:

Input: File with multiple data

Upload Service -  Case 1: New file is given, Reads the data from the file and uploads the data into Database 
				  Case 2: Existing/Half processed file is given, data from recovery point has to be processed

Stop Service   -  When stop is triggered, if file upload is in progress, we need to rollback the uploaded data

Kill Service   -  When kill is triggered, if file upload is in progress, we need to terminate the process and stop data upload. 
				  When the same file is reuploaded, we need to start from the recovery point and process remaining data(explained in Case 2 in upload service)


Status:
INITIALIZING - created a tracker for given file 
PROCESSING   - Started uploading the data to DB
STOPPED      - Upload is stopped
KILLED       - Upload is killed
PROCESSED    - Data upload is successful


API Documentation:

https://documenter.getpostman.com/view/19782404/UVkqquJj

Docker Setup:

1. Move to path that has DOckerfile and run the following command to build docker image
	
	docker build -t nivedhan/chainbrain .      

2. Once docker image is built, this can be either used locally or we can push this to docker reporsitory using below command so that anybody can pull this image to their system
  
    docker push nivedhan/chainbrain:latest

3. Once docker image is ready, we can initiate the container using docker compose file

   docker-compose pull && docker-compose up -d


docker-compose.yml file has two services, one for database and other is our application.  
docker-compose pull - This command is to pull latest image from repository. This is recommended so that we can always have the latest image
docker-compose up -d  - To start the containers


Once docker setup is done, we can access the rails application using http://localhost:3000 from your browser

![image](https://user-images.githubusercontent.com/42088074/155875737-79d6e50d-b6a4-4e0f-8d4c-34b402eec379.png)




