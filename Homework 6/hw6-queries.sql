/*
Kushagra Agarwal
CSE 414
Homework 6
Fall 2017
Professor: Gang Luo
Date: 11/27/2017
*/

 # Question 1: What is the total number of rows in the data? [2 pts]

SELECT count(*) 
FROM fbFacts
/*
Answer: 563,980,447
*/


 # Question 2: What is the number of distinct predicates in the data? [2 pts]

SELECT COUNT(DISTINCT predicate) 
FROM fbFacts
/*
Answer: 18,944
*/


# Question 3: In the example in the description, we showed some tuples 
# with the subject of MID /m/0284r5q. What are all the tuples with the 
# subject of MID /m/0284r5q? [3 pts]


SELECT * 
FROM fbFacts 
WHERE subject = '/m/0284r5q'
/*
Answer: 

subject		predicate							obj								context

/m/0284r5q	/type/object/key				/wikipedia/en_id				9,327,603
/m/0284r5q	/type/object/key				/wikipedia/en			Flyte_$0028chocolate_bar$0029
/m/0284r5q	/type/object/key				/wikipedia/en_title		Flyte_$0028chocolate_bar$0029
/m/0284r5q	/common/topic/article			/m/0284r5t	
/m/0284r5q	/type/object/type				/common/topic	
/m/0284r5q	/type/object/type				/food/candy_bar	
/m/0284r5q	/type/object/type				/business/brand	
/m/0284r5q	/type/object/type				/base/tagit/concept	
/m/0284r5q	/food/candy_bar/manufacturer	/m/01kh5q	
/m/0284r5q	/common/topic/notable_types		/business/brand	
/m/0284r5q	/common/topic/notable_types		/food/candy_bar	
/m/0284r5q	/food/candy_bar/sold_in			/m/09c7w0	
/m/0284r5q	/common/topic/notable_for					 			{"types":[], "id":"/food/candy_bar", 
																	"property":"/type/object/type", 
																	"name":"Candy bar"}
/m/0284r5q	/type/object/name				/lang/en						Flyte
/m/0284r5q	/common/topic/image				/m/04v6jtv	
*/


# Question 4: How many travel destinations does Freebase have? To do this, 
# we'll use the type /travel/travel_destination. In particular, 
# we want to find the number of subjects that have a /type/object/type 
# predicate with the object equal to /travel/travel_destination. [3 pts]

SELECT COUNT(subject) 
FROM fbFacts 
WHERE predicate = '/type/object/type' 
AND obj = '/travel/travel_destination'
/*
Answer: 295
*/


# Question 5: Building off the previous query, what 20 travel destination have 
# the most tourist attractions? Return the location name and count. [4 pts]
# Use the /travel/travel_destination/tourist_attractions predicate to 
# find the tourist attractions for each destination. Use the /type/object/name 
# predicate and /lang/en object to get the name of each location 
# (the name will be the context of the tuple with predicate /type/object/name and object /lang/en).
# Sort your result by the number of tourist attractions from largest to smallest and then 
# on the destination name alphabetically and only return the top 20


SELECT tb1.c, tb2.context
FROM ( SELECT DISTINCT subject, COUNT(obj) AS c 
	   FROM fbFacts 
	   WHERE predicate = '/travel/travel_destination/tourist_attractions/' 
	   GROUP BY subject) AS tb1
INNER JOIN 
	 ( SELECT subject, context 
	   FROM fbFacts 
	   WHERE predicate = '/type/object/name' 
	   AND obj = '/lang/en') AS tb2
ON tb1.subject = tb2.subject
GROUP BY tb1.context
ORDER BY tb2.c DESC
LIMIT 20




# Question 6: Generate a histogram of the number of distinct predicates per subject. [6 pts]

SELECT subject, COUNT(distinct predicate) c 
FROM fbFacts
GROUP BY subject


# ADDITIONAL QUESTIONS .........................

/*
# Question 1: 
# By default, Spark looks in HDFS for data, but you 
# can actually tell Spark to read files locally, rather than from HDFS. 
# For this to work, what additional preprocessing step would I need to 
# take before even opening my Zeppelin notebook to prepare the data?
*/

# ANSWER: Transferring the file to the /tmp/ directory for Spark to access.

/*
#  Question 2: 
# How is Spark different from MapReduce?
*/

# ANSWER: Spark writes intermediate results to memory while Hadoop writes to disk.


/*
# Question 3: 
# Which of the following is NOT a good use case of MapReduce?
*/

# ANSWER: Computing matrix multiplication on two massive matrices.


/*
# Question 4: 
# In a simple MapReduce job with m mapper tasks and r reducer tasks, 
# how many output files do you get?
*/

# ANSWER: r (The number of files for a MapReduce job should be equal to the number of 
# 			 reducer tasks.)


/*
# Question 5: 
# One of the key features of Map-Reduce and Spark is their ability to 
# cope with server failure. For each statement below indicate whether 
# it is true or false.

	# a. In MapReduce, every map task and every reduce task is replicated across several workers.

	# Answer: False


	# b. When a server fails, Spark recomputes the RDD partitions at 
	# that server from parent RDD partitions.

	# Answer: True


	# c. In Spark, when the programmer calls the persist() function, 
	# the data is stored on disk, to facilitate recovery from failure.

	# Answer: True


	# d. When a server running a reduce task fails, MapReduce 
	# restarts that reduce task either at the same or another server, 
	# reusing data stored in local files at the mappers.

	# Answer: True

*/














