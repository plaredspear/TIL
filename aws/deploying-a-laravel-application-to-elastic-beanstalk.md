# Deploying a Laravel Application to Elastic Beanstalk

[Deploying a Laravel Application to Elastic Beanstalk](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/php-laravel-tutorial.html)


## Prerequisites


## Install Composer


## Install Laravel and Generate a Website


## Create an Elastic Beanstalk Environment and Deploy Your Application

Source Bundle requirements:
- Consist of a single `ZIP` file or `WAR` file (you can include multiple `WAR` files inside your `ZIP` file)
- Not exceed 512 MB
- Not Include a parent folder or top-level directory (subdirectories are fine)


### To launch an environment (console)

- Elastic Beanstalk console.
- Choose an applicaiton or create a new one.
- Create Ne wenvironment
- Choose Web server
- For Platform, choose the platform
- upload app code

Laravel은 public 폴더가 기준이기 때문에, Elastic Beanstalk의 document root를 거기에 맞춰줘야 한다.


## Add a Dataase to Your Environment


### To add an RDS DB instance to your Elastic Beanstalk environment

Creating a database instance takes about 10 minutes.

Configure the database environment variable in `config/database.php`


### To update your Elastic Beanstalk environment


## Clean Up and Next Steps


### To terminate your Elastic Beanstalk environment

Elastic Beanstalk terminates all AWS resources associated with your environment, including EC2 instances, DB instance, load balancer, security groups, Amazon CloudWatch alarms, etc.
