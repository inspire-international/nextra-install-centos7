# Nextra6.5 for CentOS 7 in Docker

This will create a CentOS 7 Docker image in which Nextra6.5 is installed.

# Prerequisite
Software: Docker

# Preparation

1) On your HostOS, issue the following git command to create the clone.

```sh
    $git clone https://github.com/inspire-international/nextra-install-centos7.git
```

2) cd to nextra-install-centos7 and kick the build.sh.

```sh
    $./build.sh 
```

3) kick the run.sh to create & start the container.

```sh
    $./run.sh 
```

4) stop the container.


```sh

    $./stop.sh

```



5) From 2nd time, use start.sh to start the container.



```sh

    $./start.sh

```



# Test Drive

1) nextra-rest-server

```sh
    http://localhost:8080
```

2) Message Queue

```sh
    $./login.sh
    # cd $ODEDIR/../samples/queue/java
    Then, follow README.txt
```

[Nextra](http://www.inspire-intl.com/product/product_nextra.html)

#### Copyright (C) 1998 - 2015  Inspire International Inc.