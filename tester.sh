# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ael-bekk <ael-bekk <ael-bekk@student.13    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/15 14:44:38 by ael-bekk          #+#    #+#              #
#    Updated: 2022/02/17 16:10:43 by ael-bekk         ###   ########.fr        #
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

if [ $# -gt 1 ]
then
    echo -e "${red}no args chould enter${reset}" >&2 ; exit
fi

chmod +x srcs/*

printf "$RED$l1\n\n"
s1="██████╗ ██╗██████╗ ███████╗██╗  ██╗    ████████╗███████╗███████╗████████╗███████╗██████╗"
s2="██╔══██╗██║██╔══██╗██╔════╝╚██╗██╔╝       ██╔══╝██╔════╝██╔════╝   ██╔══╝██╔════╝██╔══██╗"
s3="██████╔╝██║██████╔╝█████╗   ╚███╔╝        ██║   █████╗  ███████╗   ██║   █████╗  ██████╔╝"
s4="██╔═══╝ ██║██╔═══╝ ██╔══╝   ██╔██╗        ██║   ██╔══╝  ╚════██║   ██║   ██╔══╝  ██╔══██╗"
s5="██║     ██║██║     ███████╗██╔╝ ██╗       ██║   ███████╗███████║   ██║   ███████╗██║   ██╗"
s6="╚═╝     ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝        ╚╝   ╚══════╝╚══════╝    ╚╝   ╚══════╝╚═╝   ╚═╝"
for (( i=0; i<${#s1}; i++ )); do
  printf "%s" "${s1:$i:1}"
done
echo ""
for (( i=0; i<${#s2}; i++ )); do
  printf "%s" "${s2:$i:1}"
done
echo ""
for (( i=0; i<${#s3}; i++ )); do
  printf "%s" "${s3:$i:1}"
done
echo ""
for (( i=0; i<${#s4}; i++ )); do
  printf "%s" "${s4:$i:1}"
done
echo ""
for (( i=0; i<${#s5}; i++ )); do
  printf "%s" "${s5:$i:1}"
done
echo ""
for (( i=0; i<${#s6}; i++ )); do
  printf "%s" "${s6:$i:1}"
done
echo ""
printf "\n$l1$RESET\n"
sleep 1
printf "                                 Tester is ready!"
printf "\n$RED$l1$RESET\n\n"

if [ $# -eq 1 ]
then
    mines="$1"
    firstCharacter=${mines::1}
    all_clear=`echo $1 | sed "s/e//g" | sed "s/m//g" | sed "s/p//g" | sed "s/h//g" | sed "s/a//g"`
    err=`echo $1 | grep e`
    mult=`echo $1 | grep m`
    pip=`echo $1 | grep p`
    herd=`echo $1 | grep h`
    all=`echo $1 | grep a`
    
    if [ "$err" != "" ] || [ "$mult" != "" ] || [ "$pip" != "" ] || [ "$herd" != "" ] || [ "$all" != "" ]
    then
        all_clear=`echo $all_clear | sed "s/-//g"`
    fi
    
    
    if [ "$all_clear" != "" ] || [ "$firstCharacter" != "-" ]
    then
        echo $GREEN"usage: ./tester.sh [-aemph] [-a all_tests]"
        echo  "                   [-e error_handling_tests] [-m multi_pipe_tests] [-p one_pipe_tests] [-h here_doc_tests]$RESET\n" >&2 ; exit
    fi
 
    if [ "$err" != "" ] || [ "$all" != "" ]
    then
        ./srcs/error_handling_m.sh "../pipex"
        ./srcs/error_handling_b.sh "../pipex"
        ./srcs/error_handling_h.sh "../pipex"
    fi
    if [ "$pip" != "" ] || [ "$all" != "" ]
    then
        ./srcs/one_pipe.sh ../pipex
    fi
    if [ "$mult" != "" ] || [ "$all" != "" ]
    then
        ./srcs/multi_pipe.sh ../pipex
    fi
    if [ "$herd" != "" ] || [ "$all" != "" ]
    then
        ./srcs/here_doc.sh ../pipex
    fi
else
    ./srcs/error_handling_m.sh "../pipex"
    ./srcs/error_handling_b.sh "../pipex"
    ./srcs/error_handling_h.sh "../pipex"
    ./srcs/one_pipe.sh "../pipex"
    ./srcs/multi_pipe.sh "../pipex"
    ./srcs/here_doc.sh "../pipex"
fi

for i in $(ps | grep -v zsh | grep -v TIME | grep -v tester.sh | cut -d" " -f 1)
do
  kill -9 $i &> /dev/null
done

rm -fr afsasf in_file2 in_file1 in_file in_file3 my_error outfile outfile2 ssssssss vide
