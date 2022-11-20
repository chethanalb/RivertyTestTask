
# Riverty SDET Test Task - Chethana

**Dependencies used,**
 - RestSharp
 - Specflow
 - SpecFlow.Plus.LivingDoc
 - Nunit 3

 
**Completed subtasks**
- Unit tests
- Integration Tests
- Reporting
- CI/CD in github actions
- Docker

  
# How to setup and run in local machine

  

**Prerequisites,**

  

- Jetbrains Rider IDE installed
- .net sdk:6.0 installed
- Specflow Installed using Nuget
- Nunit installed using Nuget
- Git installed

  

**Steps to setup and run in IDE (Jetbrains Rider on Mac)**

- Clone the repository using clone URL

  ![enter image description here](https://i.postimg.cc/kGzL6Fs5/Clone-url.png)

  

- Import the project in to Rider

![enter image description here](https://i.postimg.cc/9F6Z18QB/Open-project-new.png)


- Build the Solution

- Run the project to execute the .net service

![enter image description here](https://i.postimg.cc/1RjkjsSZ/Run.png)


- Run Unit Tests

![enter image description here](https://i.postimg.cc/P5m0JDwt/Manually-run-unit-tests.png)


- Run Integration tests

![enter image description here](https://i.postimg.cc/yNstZNm0/Manually-run-Integration.png)


- View results in Unit Test Explorer

![enter image description here](https://i.postimg.cc/5NQhcT9Q/Test-Results-In-Rider.png)



# How to run using docker image (MacOS)

  

**Prerequisites,**

- Docker installed

  

**Steps to setup and run**

  

- Download the docker image using
-  "**docker pull ubandc2/chethana:a15eefe1342dcb62d812e2fe718af51f6ef0d22e**" command

  

- Open docker application and run the pulled docker image

![image](https://i.postimg.cc/MGZRzL77/run.png)

  

- Click on image name and open terminal in next page

![image](https://i.postimg.cc/7Zn0842P/terminal.png)


- Execute **"dotnet run -p CardValidation.Web/CardValidation.Web.csproj"** command to execute the .net service.

![enter image description here](https://i.postimg.cc/2SpPCG3c/Open-new-terminal.png)


- Open external terminal in same container and Execute **"dotnet test"** command to run Unit and Integration Tests.

  ![enter image description here](https://i.postimg.cc/Y9SPdyy9/Results-in-docker.png)
  

# Reporting

**SpecFlow+LivingDoc Generator**: If you want to generate a self-hosted HTML documentation with no external dependencies so you have the freedom to share it as you wish, then we suggest the SpecFlow plugin and command-line tool.

Steps:

 1. Install the "SpecFlow.Plus.LivingDoc" plugin using Nuget.
 2. Open Terminal and run "dotnet tool install --global SpecFlow.Plus.LivingDoc.CLI"
 3. Navigate to "SDET_Test/CardValidationIntegrationTests/bin/Debug/net6.0/" using terminal
 4. Execute "livingdoc test-assembly CardValidationIntegrationTests.dll -t TestExecution.json" command

Now user can find the "LivingDoc.html" in the "net6.0" folder. By opening it in a web browser, user will be able to analyse the detailed test execution report as below.


![enter image description here](https://i.postimg.cc/DZyk4cVr/Report.png)


 
