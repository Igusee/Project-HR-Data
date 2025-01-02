# HR data Project 

The data and idea for this project were inspired by a video from the YouTube channel Her Data Project.

## About my data: 
* Over 20K distinct records of employees in .csv format.
* Simple HR data, without any financial informations.
* Mostly properly formatted, with a few exceptions in data fields.

## MySQL Query
* Created database
* Loaded records from .csv file using built in tool in MySQL Workbench.
* Cleaned columns with incorrect data formats using `CASE` command.
* Fixed some issues generated by cleanup using `CASE` and `DATE_SUB`.
* Changed data types where necessary.
* Added calculated column with age of employee based on birthdates.
* Connected database to PowerBI.
* The .sql file is in this repo - feel free to check it out :)

## PowerBI 
* After loading data I reviewed data types once again.
* Ensured that all date columns loaded properly.
* Since Power Query tasks were handled in MySQL, I proceeded directly to analysing the data.
* Created calculated columns and measures using for example `SUMMARIZE`, `COUNTX` or `SWITCH` in DAX.
* Created dashboard tailored to my needs using columns and measures.
* Formatted my dashboards.
* The .pbix file as well as PDF dashboards are also attached in this repo! 

## This is the end of this project, I hope you enjoyed it as much as I did! 
