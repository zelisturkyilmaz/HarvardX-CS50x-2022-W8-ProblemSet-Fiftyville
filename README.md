# CS50's Introduction to Computer Science
## HarvardX - CS50x
### Week 8 Problem Set - Fiftyville
<hr>


### Assignment and Requirements:
Provided by fiftyville.db, a SQLite database which contains tables of data from around the town.Query that table using SQL ```SELECT``` queries to access the data of interest. Using just the information in the database, task is to solve the mystery.


#### Execution:

In a terminal window, run 

```
$ sqlite3 fiftyville.db
```

when ```sqlite3``` prompts you to provide a query, type 

```
.schema
``` 
and press enter. 
This will output the ```CREATE TABLE``` statements that were used to generate each of the tables in the database. By examining those statements, one can identify the columns present in each table.
