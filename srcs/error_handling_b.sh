# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    error_handling_b.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ael-bekk <ael-bekk <ael-bekk@student.13    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/17 11:22:13 by ael-bekk          #+#    #+#              #
#    Updated: 2022/02/17 17:18:10 by ael-bekk         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

l1="======================================================================================="
l2="---------------------------------------------------------------------------------------\n"
GREEN="\033[38;2;57;181;74m"
RED="\033[38;2;222;56;43m"
BLUE="\033[38;2;34;183;235m"
YELLOW="\033[38;2;255;176;0m"
PURPLE="\033[38;2;255;105;180m"
WHITE="\033[1;37m"
RESET="\033[0m"


printf "\n\n\n\n${GREEN}test error handling on multi pipe:${RESET}"
printf "$RED$l2$RESET"

make fclean -C ..

printf "${YELLOW}[make] :${RESET} your pipex: ${PURPLE}Bonus${RESET}\n"
make bonus -C ..
printf "$RED$l2$RESET"

if ! [ -f "$1" ]
then
	printf "${YELLOW}Error :${RESET} No such file or directory: ${PURPLE}pipex${RESET}\n" >&2 ; exit
fi

echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \nlim\n a dasd sd \n asdasd asdasdsbvfsbvsdd asd asd\n afdsvdsvasdqpkqwd ew edfsb\nlim2\nfdbdfbdfbfsbdfbqckqwxqwx qw \n qfqwodeqm domw	m	\tefeqc eqew cewx ewc ewc ewc wc ew" > in_file
echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \n" > in_file1
echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \nlim\n a dasd sd \n asdasd asdasdsbvfsbvsdd asd asd\n afdsvdsvasdqpkqwd ew edfsb\n" > in_file2

	timeout() {
	    ( $1 "$2" "$3" "$4" "$5" 2> my_error ) & pid=$!
	    ( sleep 3 && kill -HUP $pid ) 2>/dev/null & watcher=$!
	    if wait $pid 2>/dev/null; then
	        status="finished"
	        pkill -HUP -P $watcher
	        wait $watcher
	    else
	        status="interrupted"
	    fi
	}

	timeout_1() {
	    ( $1 "$2" "$3" "$4" "$5" "$6" 2> my_error ) & pid=$!
	    ( sleep 7 && kill -HUP $pid ) 2>/dev/null & watcher=$!
	    if wait $pid 2>/dev/null; then
	        status="finished"
	        pkill -HUP -P $watcher
	        wait $watcher
	    else
	        status="interrupted"
	    fi
	}

	timeout_2() {
	    ( $1 "$2" "$3" "$4" "$5" "$6" "$7"  "$8" "$9" 2> my_error ) & pid=$!
	    ( sleep 8 && kill -HUP $pid ) 2>/dev/null & watcher=$!
	    if wait $pid 2>/dev/null; then
	        status="finished"
	        pkill -HUP -P $watcher
	        wait $watcher
	    else
	        status="interrupted"
	    fi
	}

	timeout2() {
	    ( $1 "$2" "$3" "$4" "$5" 2> my_error ) & pid=$!
	    ( sleep 10 && kill -HUP $pid ) 2>/dev/null & watcher=$!
	    if wait $pid 2>/dev/null; then
	        status="finished"
	        pkill -HUP -P $watcher
	        wait $watcher
	    else
	        status="interrupted"
	    fi
	}

	timeout2_1() {
	    ( $1 "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" 2> my_error ) & pid=$!
	    ( sleep 10 && kill -HUP $pid ) 2>/dev/null & watcher=$!
	    if wait $pid 2>/dev/null; then
	        status="finished"
	        pkill -HUP -P $watcher
	        wait $watcher
	    else
	        status="interrupted"
	    fi
	}



echo "${PURPLE}==============>Test 1${RESET}"
printf "${WHITE}\t< non_exist_input cat /dev/random | head -n 5                          		       : ${RESET}"
timeout "$1" "in_fsdile" "cat /dev/random" "head -n 5" "outfile"
find_smae_err=`cat my_error | grep -a "no such file or directory\|No such file or directory" | wc -l`
if [ "$status" = "finished" ] && [ "$find_smae_err" -eq "1" ] 
    then
    printf "${GREEN}[OK]${RESET}\n"
else
    printf "${RED}[KO]${RESET}\n"
fi
sleep 0.7


	printf "${PURPLE}==============>Test 2${RESET}"
	printf "${WHITE}\t< exist_input catds /dev/random | ls | wc -l                           		   : ${RESET}"
	timeout_1 "$1" "in_file" "catds /dev/random" "ls" "wc -l" "outfile"
	find_smae_err=`cat my_error | grep -a "command not found\|Command not found" | wc -l`
	ls | wc -l > outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "finished" ] && [ "$find_smae_err" -eq "1" ] && [ "$different" = "" ] 
		then
		printf "${GREEN}[OK]${RESET}\n"
	else
		printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7



	printf "${PURPLE}==============>Test 3${RESET}"
	printf "${WHITE}\t< non_exist_input cat /dev/random | wc | ls                            		   : ${RESET}"
	timeout_1 "$1" "sdfin_file" "cat /dev/random" "wc" "ls" "outfile"
	find_smae_err=`cat my_error | grep -a "no such file or directory\|No such file or directory" | wc -l`
	find_smae_err2=`cat my_error | grep -a "command not found\|Command not found" | wc -l`
	ls > outfile2
	different=`diff outfile outfile2`
	if [ "$different" = "" ] && [ "$find_smae_err" -eq "1" ] && [ "$find_smae_err2" -eq "0" ] && [ "$different" = "" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7

	printf "${PURPLE}==============>Test 4${RESET}"
	printf "${WHITE}\t< exist_input csfat | wc -cl  | wasdc   |  grep 0  | sort | cat       		   : ${RESET}"
	timeout_2 "$1" "in_file" "cewfat" "wc -cl" "wwefc" "grep 0" "so/rt" "cat" "outfile"
	find_smae_err=`cat my_error | grep -a "command not found\|Command not found" | wc -l`
	find_smae_err2=`cat my_error | grep -a "no such file or directory\|No such file or directory" | wc -l`
	printf "" > vide
	< vide cat > outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "finished" ] && [ "$different" = "" ] && [ "$find_smae_err" -eq "2" ] && [ "$find_smae_err2" -eq "1" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7


	printf "${PURPLE}==============>Test 5${RESET}"
	printf "${WHITE}\t< non_exist_input sleep 12 | sleep | sleep 7 | sleep 8 | sleep 4 | sleep 5 | sleep 2   : ${RESET}"
	SECONDS=0;
	timeout2_1 "$1" "in_fiasfle" "sleep 12" "sleep 7" "sleep 8" "sleep 4" "sleep 5" "sleep 2" "outfile"
	find_smae_err=`cat my_error | grep -a "no such file or directory\|No such file or directory" | wc -l`
	if [ "$status" = "finished" ] && [ "$SECONDS" -eq "8" ] && [ "$find_smae_err" -eq "1" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
