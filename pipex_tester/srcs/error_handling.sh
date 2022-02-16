# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    error_handling.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ael-bekk <ael-bekk <ael-bekk@student.13    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/15 14:44:56 by ael-bekk          #+#    #+#              #
#    Updated: 2022/02/16 16:18:16 by ael-bekk         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

GREEN="\033[38;2;57;181;74m"
RED="\033[38;2;222;56;43m"
BLUE="\033[38;2;34;183;235m"
YELLOW="\033[38;2;255;176;0m"
PURPLE="\033[38;2;255;105;180m"
RESET="\033[0m"

if ! [ -f "$1" ]
then
	echo -e "${YELLOW}Error :${reset} No such file or directory: ${white}pipex${reset}" >&2 ; exit
fi

echo "${PURPLE}==============>Test 9${RESET}"
printf "${WHITE}\t/srcs/affich_messag.sh  | cat                                  : ${RESET}"
timeout "$1" "in_file" /srcs/a.out "cat" "outfile"
< in_file /srcs/a.out | cat > outfile2
different=`diff outfile outfile2`
if [ "$status" = "finished" ] && [ "$different" = "" ]
    then
    echo "${GREEN}[OK]${RESET}\n"
else
    echo "${RED}[KO]${RESET}\n"
fi