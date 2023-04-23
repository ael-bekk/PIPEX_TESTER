# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    here_doc.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ael-bekk <ael-bekk <ael-bekk@student.13    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/15 14:44:54 by ael-bekk          #+#    #+#              #
#    Updated: 2022/02/19 11:53:23 by ael-bekk         ###   ########.fr        #
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


printf "\n\n\n\n${GREEN}test your pipex with here_doc :${RESET}"
printf "$RED$l2$RESET"

make fclean -C ..

printf "${YELLOW}[make] :${RESET} your pipex (here_doc): ${PURPLE}Bonus${RESET}\n"
make bonus -C ..
printf "$RED$l2$RESET"

if ! [ -f "$1" ]
then
	printf "${YELLOW}Error :${RESET} No such file or directory: ${PURPLE}pipex${RESET}\n" >&2 ; exit
fi

echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \nlim\n a dasd sd \n asdasd asdasdsbvfsbvsdd asd asd\n afdsvdsvasdqpkqwd ew edfsb\nlim2\nfdbdfbdfbfsbdfbqckqwxqwx qw \n qfqwodeqm domw	m	\tefeqc eqew cewx ewc ewc ewc wc ew" > in_file
echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd " > in_file1
echo "sgfefeqd qwdqwdddafasd s+64 65 30 9 2 92 ad asd lim asd as d asd\n asdasd \nlim\n a dasd sd \n asdasd asdasdsbvfsbvsdd asd asd\n afdsvdsvasdqpkqwd ew edfsb" > in_file2

	timeout() {
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" &> /dev/null ) & pid=$!
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
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" "$7" &> /dev/null ) & pid=$!
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
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" "$7"  "$8" "$9" &> /dev/null ) & pid=$!
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
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" &> /dev/null ) & pid=$!
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
	    ( < in_file $1 "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" &> /dev/null ) & pid=$!
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
	printf "${PURPLE}==============>Test 1${RESET}"
	printf "${WHITE}\tcat /dev/random | head -n 5                                     : ${RESET}"
	timeout "$1" here_doc lim "cat /dev/random" "head -n 5" "outfile"
	if [ "$status" = "finished" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
	printf "" > outfile

	printf "${PURPLE}==============>Test 2${RESET}"
	printf "${WHITE}\tcat /dev/random | /usr/bin/tail -n 5 | wc -l                    : ${RESET}"
	timeout_1 "$1" here_doc lim2 "cat /dev/random" "/usr/bin/tail -n 5" "wc -l" "outfile"
	if [ "$status" = "interrupted" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
	printf "" > outfile

	printf "${PURPLE}==============>Test 3${RESET}"
	printf "${WHITE}\tcat /dev/random | wc | ls                                       : ${RESET}"
	timeout_1 "$1" here_doc lim "cat" "wc" "ls" "outfile"
	ls >> outfile2
	different=`diff outfile outfile2`
	if [ "$different" = "" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7

	printf "${PURPLE}==============>Test 4${RESET}"
	printf "${WHITE}\tcat | wc -cl | grep 0 | sort | cat                              : ${RESET}"
	timeout_2 "$1" here_doc lim "cat" "wc -cl" "grep 0" "sort" "cat" "outfile"
	< in_file1 cat | wc -cl |  grep 0  | sort | cat >> outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "finished" ] && [ "$different" = "" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7

	printf "${PURPLE}==============>Test 5${RESET}"
	printf "${WHITE}\tcat | cat | cat | cat | wc                                      : ${RESET}"
	timeout_2 "$1" here_doc lim2 "cat" "cat" "cat" "cat" "wc" "outfile"
	< in_file2 cat | cat | cat | cat | wc  >> outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "finished" ] && [ "$different" = "" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7

	printf "${PURPLE}==============>Test 6${RESET}"
	printf "${WHITE}\tcat | sort | ls | cat | wc                                      : ${RESET}"
	timeout_2 "$1" here_doc lim2 "cat" "sort" "ls" "cat" "wc" "outfile"
	< in_file2 cat | sort | ls | cat | wc  >> outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "finished" ] && [ "$different" = "" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
	printf "" > outfile
	printf "" > outfile2

	printf "${PURPLE}==============>Test 7${RESET}"
	printf "${WHITE}\tsleep 9 | sleep 4                                               : ${RESET}"
	SECONDS=0;
	timeout2 "$1" here_doc lim2 "sleep 9" "sleep 4" "outfile"
	if [ "$status" = "finished" ] && [ "$SECONDS" -eq "9" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
	printf "" > outfile

	printf "${PURPLE}==============>Test 8${RESET}"
	printf "${WHITE}\tcat | sort | cat /dev/random | ls| wc                           : ${RESET}"
	timeout2_1 "$1" here_doc lim "cat" "sort" "cat /dev/random" "ls" "wc" "outfile"
	< in_file1 cat | sort | cat /dev/random | ls | wc >> outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "finished" ] && [ "$different" = "" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7

	printf "${PURPLE}==============>Test 9${RESET}"
	printf "${WHITE}\tsleep 1 | sleep | 7 | sleep 8 | sleep 4 | sleep 2               : ${RESET}"
	SECONDS=0;
	timeout2_1 "$1"  here_doc lim "sleep 1" "sleep 7" "sleep 8" "sleep 4" "sleep 2" "outfile"
	if [ "$status" = "finished" ] && [ "$SECONDS" -eq "8" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7

	printf "${PURPLE}==============>Test 10${RESET}"
	printf "${WHITE}\tsleep 9 | sleep 1 | sleep 3 | sleep 4 | sleep 5                 : ${RESET}"
	SECONDS=0;
	timeout2_1 "$1" here_doc lim "sleep 9" "sleep 1" "sleep 3" "sleep 4" "sleep 5" "outfile"
	if [ "$status" = "finished" ] && [ "$SECONDS" -eq "9" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
	printf "" > outfile
	printf "" > outfile2

	printf "${PURPLE}==============>Test 11${RESET}"
	printf "${WHITE}\tsrcs/a.out | wc                                                 : ${RESET}"
	timeout "$1" here_doc lim2 "srcs/a.out" "wc" "outfile"
	< in_file2 srcs/a.out | wc >> outfile2
	different=`diff outfile outfile2`
	if [ "$status" = "finished" ] && [ "$different" = "" ]
	    then
	    printf "${GREEN}[OK]${RESET}\n"
	else
	    printf "${RED}[KO]${RESET}\n"
	fi
	sleep 0.7
