#!/bin/bash

#---------------------------------------------------------
# Purpose: Eliminate manual labor by automating our weekly server updates and upgraded package logging using a bash script.
# Name: Dwayne Toler
# 8/28/23
#---------------------------------------------------------

# to schedule our cron job (https://www.youtube.com/watch?v=7cbP7fzn0D8&t=934s)
# IN OUR TERMINAL, WE WILL TYPE IN THE COMMAND 'crontab -e'. THIS WILL OPEN OUR FILE WHERE OUR CRON JOBS WILL BE STORED.
# ONCE WE ARE IN THERE, WE NEED TO SCROLL TO THE BOTTOM OF THE PAGE AND ADD THE FOLLOWING COMMAND "0 23 * * 5 /home/ubuntu/assignments/server_update_assignment/server_update_script.sh"
# THE CRON COMMAND ABOVE WILL RUN OUR SERVER SCRIPT EVERY FRIDAY AT 11PM.
# (0 23 * * 5) this tells the cron job to run exactly at the begining (0) of the 23rd hour (23) on the 5th day (5) of every week.

# We will use the "date" command to get the current date and store it in a variable called "curent_date" so that we can use it later on to create our file name
current_date=$(date +'%m.%d.%y')

# We need somewhere to store the files we'll be making so we'll make a directory called "server_updates_logs" using the "mkdir" command. We'll also use the "-p" flag so that our script starts out by checking if theres already a directory called "server_updates_logs" and if its not, it'll make one.
mkdir -p server_updates_logs

# We'll navigate into the directory where our server logs will be kept so that our script can run its commands and save inside the folder where the logs will be kept
cd server_updates_logs

# We'll use the "apt" command to "update" and "upgrade" our server. We will run both of those commands with the "-y" flag so that "yes" is selected after each command prompts us for a response.
sudo apt update -y && sudo apt upgrade -y


# to upgrade packages (https://www.baeldung.com/linux/list-upgradable-packages#:~:text=With%20the%20–upgradable%20argument%20to,run%20apt%20upgrade%20as%20usual.).... & to count the number of upgradable packages listed (https://www.baeldung.com/linux/bash-count-lines-in-file#:~:text=The%20wc%20command%20is%20used,the%20name%20of%20the%20file.)

# We'll get the number of upgraded packages. We use "apt list --upgradable" to return us a list of upgradable packages. We'll use the "|" symbol to take the output of everything on left of the "|", then use it as the inut to run the "wc -l" command that will count the number of lines in our list of upgradable files. And we will store it all in a variable called "upgraded_packages"
upgraded_packages=$(apt list --upgradable | wc -l)

# We'll use the 'current_date' varibale we made earlier to create the string that we will use to name the file that will have our server log data. We'll store that in a variable too.
server_log_file="update$current_date.txt"

# We'll write the number of packages to our file
echo "Number of upgraded packages: $upgraded_packages" > "$server_log_file"

#We'll display the number of packages that were upgraded for 5 seconds and then clear our screen
cat "$server_log_file"
sleep 10
clear
