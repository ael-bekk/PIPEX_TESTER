command not found\|Command not found# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    error_handling_h.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ael-bekk <ael-bekk <ael-bekk@student.13    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/17 14:45:14 by ael-bekk          #+#    #+#              #
#    Updated: 2022/02/17 17:20:04 by ael-bekk         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

l1="======================================================================================="
l2="---------------------------------------------------------------------------------------"
GREEN="\033[38;2;57;181;74m"
RED="\033[38;2;222;56;43m"
BLUE="\033[38;2;34;183;235m"
YELLOW="\033[38;2;255;176;0m"
PURPLE="\033[38;2;255;105;180m"
WHITE="\033[1;37m"
RESET="\033[0m"


echo "\n\n\n\n${GREEN}test error handling on here_doc :${RESET}"
echo "$RED$l2$RESET"

make fclean -C ..

echo "${YELLOW}[make] :${RESET} your pipex (here_doc): ${PURPLE}Bonus${RESET}"
make bonus -C ..
echo "$RED$l2$RESET"

if ! [ -f "$1" ]
then
	echo "${YELLOW}Error :${RESET} No such file or directory: ${PURPLE}pipex${RESET}\n" >&2 ; exit
fi

echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \nlim\n a dasd sd \n asdasd asdasdsbvf\n\nsbvsdd asd asd\n afdsvdsvasdqpkqwd ew edfsb\nlim2\nfdbdfbdfbfsbdfbqckqwxqwx qw \n qfqwodeqm domw	m	\tefeqc eqew cewx ewc ewc ewc wc ew" > in_file
echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \n" > in_file1
echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \nlim\n a dasd sd \n asdasd asdasdsbvfsbvsdd asd asd\n afdsvdsvasdqpkqwd ew edfsb\n" > in_file2
echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \nlim\n a dasd sd \n asdasd asdasdsbvf\n" > in_file3

	timeout() {
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" 2> my_error ) 1> /dev/null & pid=$!
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
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" "$7" 2> my_error ) 1> /dev/null & pid=$!
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
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" "$7"  "$8" "$9" 2> my_error ) 1> /dev/null & pid=$!
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
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" 2> my_error ) 1> /dev/null & pid=$!
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
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" 2> my_error ) 1> /dev/null & pid=$!
	    ( sleep 11 && kill -HUP $pid ) 2>/dev/null & watcher=$!
	    if wait $pid 2>/dev/null; then
	        status="finished"
	        pkill -HUP -P $watcher
	        wait $watcher
	    else
	        status="interrupted"
	    fi
	}



	printf "" > outfile
	printf "" > outfile2
	echo "${PURPLE}==============>Test 1${RESET}"
	printf "${WHITE}\t'here_doc ' '' > cat /dev/random | head -n 5                           		   : ${RESET}"
	timeout "$1" "here_doc " lim "cat /dev/random" "head -n 5" "outfile"
    find_smae_err=`cat my_error | grep -a "no such file or directory\|No such file or directory" | wc -l`
    find_smae_err2=`cat my_error | grep -a "command not found\|Command not found" | wc -l`
	if [ "$status" = "finished" ] && [ "$find_smae_err" -eq "1" ] && [ "$find_smae_err2" -eq "0" ] 
	    then
	    echo "${GREEN}[OK]${RESET}\n"
	else
	    echo "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
	printf "" > outfile

	echo "${PURPLE}==============>Test 2${RESET}"
	printf "${WHITE}\t'here_doc' 'lim' > cat /dev/random | wc | ls                           		   : ${RESET}"
	timeout_1 "$1" here_doc "lim2" "cat /dev/random" "wc" "ls" "outfile"
	ls > outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "interrupted" ] && [ "$different" = "" ]
	    then
	    echo "${GREEN}[OK]${RESET}\n"
	else
	    echo "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7

    echo "${PURPLE}==============>Test 3${RESET}"
	printf "${WHITE}\t'here_doc' 'lim ' > tcat  | wc | ls                                      		   : ${RESET}"
	timeout_1 "$1" here_doc "lim2 " "cat" "wc" "ls" "outfile"
    find_smae_err=`cat my_error | grep -a "no such file or directory\|No such file or directory" | wc -l`
    find_smae_err2=`cat my_error | grep -a "command not found\|Command not found" | wc -l`
	ls > outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "interrupted" ] && [ "$different" = "" ] && [ "$find_smae_err" -eq "0" ] && [ "$find_smae_err2" -eq "0" ] 
	    then
	    echo "${GREEN}[OK]${RESET}\n"
	else
	    echo "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7

    printf "" > outfile
	echo "${PURPLE}==============>Test 4${RESET}"
	printf "${WHITE}\t'here_doc' '' > cat | head -n 7 | ls                                  	 	   : ${RESET}"
	timeout_1 "$1" here_doc "" "cat" "head -n 7" "ls" "outfile"
    find_smae_err=`cat my_error`
    < in_file3 cat | head -n 5 | ls  > outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "finished" ] && [ "$different" = "" ] && [ "$find_smae_err" = "" ]
	    then
	    echo "${GREEN}[OK]${RESET}\n"
	else
	    echo "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
	printf "" > outfile
