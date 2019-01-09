#!/bin/bash

#########################################################################
#			 D I S C L A I M E R !! 			#
#									#
#	  THIS SCRIPT WILL COMMENT OUT ALL COMMANDS AND OPERATIONS	#
#         AND LET THE USER UNCOMMENT WHAT THEY WISH TO USE.		#
#									#
#########################################################################

# EXERCISE: '2b'. Sort the file on EmpCode
# COMMAND/CODE:
# cut -f1 20190107_Lab2_employee | sort
#
# COMMENT: The cut command with the -f switch selects that field,
#	   in this case field 1 on the file employee and pipes it to sort.


# EXERCISE: '2c'. Sort the file on EmpName
# COMMAND/CODE:
# cut -f2 20190107_Lab2_employee | sort
#
# COMMENT: See comment for Exercise 2b, only this time it selects field 2,
#	   and sorts on that.

# EXERCISE: '2d(i)'. Decreasing order of basic pay
# COMMAND/CODE:
# cut -f5 20190107_Lab2_employee | sort -r
#
# COMMENT: This is again the same operation as the last 2 exercises but
#	   it regards field 5, and the sort command is reversed with -r.

# EXERCISE: '2d(ii)'. Increasing order of years of experiance
# COMMAND/CODE:
# cut -f4 20190107_Lab2_employee | sort
# COMMENT: This is the same operation as in 2b and 2c but it regards
#	   field 4.

# EXERCISE: '2e'. Display the number of employees whose details are included in the file.
# COMMAND/CODE:
# wc -l 20190107_Lab2_employee
# COMMENT: The simple wc (wordcount) command with the -l option prints new line counts
#	   instead of all bytes.

# EXERCISE: '2f'. Display all records with -smith- a part of employee name.
# COMMAND/CODE
# cut -f2 –d " " 20190107_Lab2_employee | grep '^[smith]' | wc –l
# COMMENT: Here we cut out and select field 4 and with the grep command we single out what
#	   we want to filter out and then pipe that to the wc command with the -l option.

# EXERCISE: '2g'. Display all records with EmpName starting with -B-.
# COMMAND/CODE:
# cut -f2 20190107_Lab2_employee | grep '^[B]' | wc –l
# COMMENT: This is the same operation as 2f, only we're sorting on everything starting with
#	   B instead of anything containing a string.

# EXERCISE: '2h'. Display the records on employees whos grade is E2 and have work experience
#		  of 2 to 5 years.
# COMMAND/CODE:
# cut -f3 20190107_Lab2_employee | grep '[*2]' | cut -f4 20190107_Lab2_employee | grep '[2-5]'
# COMMENT: This operation is divided into two parts. First field 3 is cut to filter out
#	   employees with the grade E2. Then, based on that selection the second part filters
#	   field 4 on work experiance.

# EXERCISE: '2i'. Store in the -file_1- the names of all employees whos basic pay is between
#		  10000 and 15000.
# COMMAND/CODE: cut -f2,5 20190107_Lab2_employee | grep '[10000-15000]' > file_1
# COMMENT: First we select field 2 and 5 and the pipe that to the grep command with the range of
#	   10k to 15k salary range and add those strings to file_1.

# EXERCISE: '2j'. Display records of all employees who are not in grade E2.
# COMMAND/CODE: cut -f3 20190107_Lab2_employee | grep '[*1]'
# COMMENT: Here we select field 3 and pipe that to the grep command that filters and only shows
#	   anything including a -1- in the field. That excludes grade E2 employees.
