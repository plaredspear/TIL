# Getting Started using Elastic Beanstalk


## Step 1: Sign up for the Service


## Step 2: Create an Application

If any Elastic Beanstalk applications already exist in the region in which you want to create and deploy an application, you must follow different procedures to create a new application.


### To create a sample application

- Creates an Elastic Beanstalk application named My First Elastic Beanstalk Application.
- Launches an environment named Default-Environment with the following AWS
-- EC2 instance
-- Security group
-- Auto Scaling group
-- Amazon S3 bucket
-- Amazon CloudWatch alarms
-- Domain name
- Creates a new application version named Sample Application, which refers to the default Elastic Beanstalk sample aplication file.
- Deploys the Sample Application application into the Default-Environment.


## Step 3: View Information About Your Environment

left hand side of the console

- Configuration page
- Health page
- Monitoring page
- Events page


## Step 4: Deploy a New Application Version


## Step 5: Change Configuration

auto scale with load balancer, because of downtime.


## Step 6: Clean Up

1. Delete all application verions

2. Terminate the environment.

3. Delete the **My First Elastic Beanstalk Application** Elastic Beanstalk applicdation.
