# Test Color
# for ((i=1; i<=100; i++))
# do 
# tput setaf $i
# echo "$i"
# tput sgr0
# done

COLOR_RED="1"
COLOR_GREEN="2"
COLOR_YELLOW="3"
COLOR_BLUE="4"
COLOR_PURPLE="5"
COLOR_S_RED="9"
COLOR_S_GREEN="10"
COLOR_S_YELLOW="11"
COLOR_S_BLUE="33"
COLOR_S_PURPLE="3"
COLOR_WHITE="5"
COLOR_BLACK="16"

function echo_red {
   tput setaf ${COLOR_RED}
   echo "$1"
   tput sgr0
}

function echo_green {
   tput setaf ${COLOR_GREEN}
   echo "$1"
   tput sgr0
}

function echo_yellow {
   tput setaf ${COLOR_YELLOW}
   echo "$1"
   tput sgr0
}

function echo_blue {
   tput setaf ${COLOR_BLUE}
   echo "$1"
   tput sgr0
}

function echo_purple {
   tput setaf ${COLOR_PURLPE}
   echo "$1"
   tput sgr0
}

function echo_s_red {
   tput setaf ${COLOR_S_RED}
   echo "$1"
   tput sgr0
}

function echo_s_green {
   tput setaf ${COLOR_S_GREEN}
   echo "$1"
   tput sgr0
}

function echo_s_yellow {
   tput setaf ${COLOR_S_YELLOW}
   echo "$1"
   tput sgr0
}

function echo_s_blue {
   tput setaf ${COLOR_S_BLUE}
   echo "$1"
   tput sgr0
}

function echo_s_purple {
   tput setaf ${COLOR_S_PURLPE}
   echo "$1"
   tput sgr0
}

function echo_white {
   tput setaf ${COLOR_WHITE}
   echo "$1"
   tput sgr0
}

function echo_black {
   tput setaf ${COLOR_BLACK}
   echo "$1"
   tput sgr0
}

