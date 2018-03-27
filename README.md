# README

# SAM-SERVER application 

part of the SAM (Student Attendance Monitoring) project of Team Foxtrot 2018 at University of Aberdeen

Copyright (c) 2018 Team Foxtrot

Licensed under MIT License

## Getting started

* The following guide is for Ubuntu Linux and its variations!

* If running on local machine: install ruby and rubygems (Therefore, it can be skipped on Cloud9 IDE.)

* We will be resizing images using the image manipulation program ImageMagick, which we need to install on the development environment. 
  When using Heroku for deployment ImageMagick comes pre-installed in production.

```
$ sudo yum install -y ImageMagick
```
* Install the Rails (Version 5.1.4)

```
$ gem install rails -v 5.1.4
```

* To get started with the app, clone the repo from GitHub (private repository, access should be given)

```
$ git clone clone git@github.com:zalanfarkas/sam-server.git 
```

* Then install the needed gems:

```
$ bundle install --without production
```

* Next, migrate the database:

```
$ rails db:migrate
```

* If you are testing the system

```
$ rails db:seed
```

* Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

* If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```


