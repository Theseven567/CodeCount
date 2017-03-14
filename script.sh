#!/bin/bash



### Functions ####

totalForC(){

for dir in $(find . -type d); do (
	# We have to change if directory exists in order to avoid "No file or directory" error
    if [ -d "$dir" ];
    	then
    cd "$dir"

    # The main concern here was preventing cd comand from throwing errors and 
    # and making sure empty folders are not counted


    countSemicolonLines=$(find . -maxdepth 1 -name '*.c' -print0 | \
        xargs -0 grep '[;]$' | wc -l)
    countLines=$(find . -maxdepth 1 -name '*.c' -print0 | \
        xargs -0 grep '$' | wc -l)
    # here we want to see just directories where number of lines > 0
    if [ $countLines -ne 0 ] || [ $countSemicolonLines -ne 0 ];
    	then
    echo "${dir}\t${countLines}\t${countSemicolonLines}"
	fi
	fi
) done
	totalSemicolon=$(find . -name '*.c' -print0 | xargs -0 grep '[;]$' | wc -l)
	total=$(find . -name '*.c' -print0 | xargs -0 grep '$' | wc -l)
	echo "Total lines: ${total}"
	echo "Total semicolon ending lines: ${totalSemicolon}"
}

totalForJava(){

for dir in $(find . -type d); do (
	# We have to change if directory exists in order to avoid "No file or directory" error
    if [ -d "$dir" ];
    	then
    cd "$dir"
    countSemicolonLines=$(find . -maxdepth 1 -name '*.java' -print0 | \
        xargs -0 grep '[;]$' | wc -l)
    countLines=$(find . -maxdepth 1 -name '*.java' -print0 | \
        xargs -0 grep '$' | wc -l)
    # here we want to see just directories where number of lines > 0
    if [ $countLines -ne 0 ] || [ $countSemicolonLines -ne 0 ];
    	then
    echo "${dir}\t ${countLines}\t ${countSemicolonLines}" 
	fi
	fi
) done
	totalSemicolon=$(find . -name '*.java' -print0 | xargs -0 grep '[;]$' | wc -l)
	total=$(find . -name '*.java' -print0 | xargs -0 grep '$' | wc -l)
	echo "Total lines: ${total}"
	echo "Total semicolon ending lines: ${totalSemicolon}"
}


##  Program counts total lines of C or Java code

numOfArguments=$#

if [[ $numOfArguments == 0 ]]
	then
	echo "Wrong input. Use -h for help"
	exit 0
fi
if [[ $1 == "-c" ]];
    then
    cd $2
    totalForC
elif [[ $1 == "-j" ]];
    then
    cd $2
    totalForJava
elif [[ $1 == "-h" ]];
    then
    echo "loc function (counts the total number of lines and lines ending with a semicolon) \n accepts the following input - loc OPTION [DIRECTORY]. \n -j option for Java code \n -c option for C code."
else 
    echo "Wrong input"
    exit 0
fi



