Apache Hive (TM)
================
[![Master Build Status](https://travis-ci.org/apache/hive.svg?branch=master)](https://travis-ci.org/apache/hive/branches)
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/org.apache.hive/hive/badge.svg)](http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22org.apache.hive%22)

The Apache Hive (TM) data warehouse software facilitates reading,
writing, and managing large datasets residing in distributed storage
using SQL. Built on top of Apache Hadoop (TM), it provides:

* Tools to enable easy access to data via SQL, thus enabling data
  warehousing tasks such as extract/transform/load (ETL), reporting,
  and data analysis

* A mechanism to impose structure on a variety of data formats

* Access to files stored either directly in Apache HDFS (TM) or in other
  data storage systems such as Apache HBase (TM)

* Query execution using Apache Hadoop MapReduce, Apache Tez
  or Apache Spark frameworks.

Hive provides standard SQL functionality, including many of the later
2003 and 2011 features for analytics.  These include OLAP functions,
subqueries, common table expressions, and more.  Hive's SQL can also be
extended with user code via user defined functions (UDFs), user defined
aggregates (UDAFs), and user defined table functions (UDTFs).

Hive users have a choice of 3 runtimes when executing SQL queries.
Users can choose between Apache Hadoop MapReduce, Apache Tez or
Apache Spark frameworks as their execution backend. MapReduce is a
mature framework that is proven at large scales. However, MapReduce
is a purely batch framework, and queries using it may experience
higher latencies (tens of seconds), even over small datasets. Apache
Tez is designed for interactive query, and has substantially reduced
overheads versus MapReduce. Apache Spark is a cluster computing
framework that's built outside of MapReduce, but on top of HDFS,
with a notion of composable and transformable distributed collection
of items called Resilient Distributed Dataset (RDD) which allows
processing and analysis without traditional intermediate stages that
MapReduce introduces.

Users are free to switch back and forth between these frameworks
at any time. In each case, Hive is best suited for use cases
where the amount of data processed is large enough to require a
distributed system.

Hive is not designed for online transaction processing. It is best used
for traditional data warehousing tasks.  Hive is designed to maximize
scalability (scale out with more machines added dynamically to the Hadoop
cluster), performance, extensibility, fault-tolerance, and
loose-coupling with its input formats.


General Info
============

For the latest information about Hive, please visit out website at:

  http://hive.apache.org/


Getting Started
===============

- Installation Instructions and a quick tutorial:
  https://cwiki.apache.org/confluence/display/Hive/GettingStarted

- A longer tutorial that covers more features of HiveQL:
  https://cwiki.apache.org/confluence/display/Hive/Tutorial

- The HiveQL Language Manual:
  https://cwiki.apache.org/confluence/display/Hive/LanguageManual


Requirements
============

- Java 1.7 or 1.8

- Hadoop 1.x, 2.x (2.x required for Hive 2.x)


Upgrading from older versions of Hive
=====================================

- Hive includes changes to the MetaStore schema. If
  you are upgrading from an earlier version of Hive it is imperative
  that you upgrade the MetaStore schema by running the appropriate
  schema upgrade scripts located in the scripts/metastore/upgrade
  directory.

- We have provided upgrade scripts for MySQL, PostgreSQL, Oracle,
  Microsoft SQL Server, and Derby databases. If you are using a
  different database for your MetaStore you will need to provide
  your own upgrade script.

Useful mailing lists
====================

1. user@hive.apache.org - To discuss and ask usage questions. Send an
   empty email to user-subscribe@hive.apache.org in order to subscribe
   to this mailing list.

2. dev@hive.apache.org - For discussions about code, design and features.
   Send an empty email to dev-subscribe@hive.apache.org in order to
   subscribe to this mailing list.

3. commits@hive.apache.org - In order to monitor commits to the source
   repository. Send an empty email to commits-subscribe@hive.apache.org
   in order to subscribe to this mailing list.

What is special about this version
===================================

This version of Hive has modified `org.apache.hive.spark.client.SparkClientImpl` in `spark-client` module. Modifications are numerous (compare to the [original](https://github.com/apache/hive/blob/master/spark-client/src/main/java/org/apache/hive/spark/client/SparkClientImpl.java)).

These changes enable the usage of Spark server running on Mesos.

Here is a quick usage sample (also look at [Hive on Spark getting Started](https://cwiki.apache.org/confluence/display/Hive/Hive+on+Spark%3A+Getting+Started))

* Build Hive using `mvn clean package -Pdist -DskipTests`. The results of the build are at `packaging/target`
* Make sure you can connect remote Spark server. I used the following:
````shell
spark-submit \
	--master mesos://spark-for-hive.marathon.mesos:15457  \
	--deploy-mode cluster  \
	--conf spark.mesos.executor.docker.image=lightbend/fdp-spark-for-hive:latest  \
	--conf spark.mesos.driver.labels=DCOS_SPACE:/spark  \
	--conf spark.mesos.task.labels=DCOS_SPACE:/spark  \
	--conf spark.executor.cores=2  \
	--conf spark.executor.memory=2g  \
	--conf driver.memory=2g  \
	--conf spark.cores.max=8  \
	--class org.apache.spark.examples.SparkPi  http://jim-lab.marathon.mesos/spark-examples_2.11-2.2.0.jar  1000  
````
Make sure to set the port correctly
* Copy `hive-site.xml` from `conf` directory to the `conf` directory of created distribution. Make sure to update
```
  <property>
    <name>spark.master</name>
    <value>mesos://spark-for-hive.marathon.mesos:15457</value>
    <description>Spark Master URL.</description>
```
and
````
  <property>
    <name>spark.hive.jar.location</name>
    <value>http://jim-lab.marathon.mesos/hive-exec-3.0.0-SNAPSHOT.jar</value>
    <description>URL accessable Hive jar</description>
  </property>
````
with the locations that you need and any other parameters.
* Copy the folowing jars to the `lib` directory from your corresponding Spark - 
  `scala-library`, `spark-core` and `spark-network-common` 
* Make sure to set Hadoop and Spark home (yes you need local spark to use Spark-submit) using the following:
````
export HADOOP_HOME=...
export SPARK_HOME=..
````
* If this is the first Hive usage, create database (I am using Derby)
````
./bin/schematool -dbType derby -initSchema
````
and HDFS directories required for Hive 
````
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -mkdir -p /tmp
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod g+w /user/hive/warehouse
````

* Run hive - `hive`
* Test your installation using [Hive Getting Started](https://cwiki.apache.org/confluence/display/Hive/GettingStarted)

If everything works ok, after executing:

````
hive> CREATE TABLE u_data (
    >   userid INT,
    >   movieid INT,
    >   rating INT,
    >   unixtime STRING)
    > ROW FORMAT DELIMITED
    > FIELDS TERMINATED BY '\t'
    > STORED AS TEXTFILE;
hive> LOAD DATA LOCAL INPATH '../ml-100k/u.data' OVERWRITE INTO TABLE u_data; 
hive> SELECT COUNT(*) FROM u_data;    
````
You should see something like:

````
Query ID = admin_20171029012558_63f760be-14bc-49ec-89ca-b4f3a35118e2
Total jobs = 1
Launching Job 1 out of 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Spark Job = d07b0c14-2a96-488d-af00-15eee4175f6a

Query Hive on Spark job[0] stages: [0, 1]

Status: Running (Hive on Spark job[0])
--------------------------------------------------------------------------------------
          STAGES   ATTEMPT        STATUS  TOTAL  COMPLETED  RUNNING  PENDING  FAILED  
--------------------------------------------------------------------------------------
Stage-0 ........         0      FINISHED      1          1        0        0       0  
Stage-1 ........         0      FINISHED      1          1        0        0       0  
--------------------------------------------------------------------------------------
STAGES: 02/02    [==========================>>] 100%  ELAPSED TIME: 11.20 s    
--------------------------------------------------------------------------------------
Status: Finished successfully in 11.20 seconds
OK
100000

````
The way Hive on Spark works is that when a first time a call to Spark is made, a cluster is created
and RPC connection to it is establish. The cluster will not be destroyed until 
Hive is not completed. This means two things:
* First request to Spark is significantly slower compared to subsequent requests
* When deciding on the size of the cluster, make sure you create large enough
  cluster for any Hive operation.


