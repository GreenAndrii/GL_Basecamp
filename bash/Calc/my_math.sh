# math function for Calc
function MY_MATH_FLOAT(){
local A operation B
A=$1
operation=$2
B=$3
if [[ $(expr index $A '.') -eq 0 && $(expr index $B '.') -eq 0 &&  "$operation" != "/" ]];
  then
	  echo $(expr $A "$operation" $B)
  else
	  [[ $(expr index $A '.') -ne 0 ]] && dot_A=$((${#A} - $(expr index $A '.'))) || dot_A=0
		[[ $(expr index $B '.') -ne 0 ]] && dot_B=$((${#B} - $(expr index $B '.'))) || dot_B=0
    add_A=$(($DIGITS - $dot_A))
		add_B=$(($DIGITS - $dot_B))
		[[ $dot_A -ge $dot_B ]] && dot_comm=$dot_A || dot_comm=$dot_B
		A=$(echo $A | tr -d '.')
		B=$(echo $B | tr -d '.')
		case "$operation" in
			'+')
				  printf %\."$dot_comm"f "$(expr $(($A * 10 ** $add_A)) "$operation" $(($B * 10 ** $add_B)))e-$DIGITS";;
			'-')
			    printf %\."$dot_comm"f "$(expr $(($A * 10 ** $add_A)) "$operation" $(($B * 10 ** $add_B)))e-$DIGITS";;
			'*')
			    printf %\."$(($dot_A + $dot_B))"f "$(expr $(($A * 10 ** $add_A)) "$operation" $(($B * 10 ** $add_B)))e-$(($DIGITS * 2))";;
			'/')
			    printf %\."$DIGITS"f "$(expr $(($A * 10 ** $add_A)) "$operation" $B)e-$add_B";;
    esac
fi
}

function help() {
	echo -e "Version: $VERSION\nEnter math expression for its calculation."
	echo -e "use \"$0 Number1 +-/* Number2\""
}

rpn() {
    local A B stack

    while [ $# -ge 1 ]; do
        grep -iE '^-?[0-9]+$' <<< "$1" > /dev/null 2>&1
        if [ "$?" -eq 0 ]; then
            stack=`sed -e '$a'"$1" -e '/^$/d' <<< "$stack"`
        else
            grep -iE '^[\/+*-]$' <<< "$1" > /dev/null 2>&1
            if [ "$?" -eq 0 ]; then
                B=`sed -n '$p' <<< "$stack"`
                stack=`sed '$d' <<< "$stack"`
                A=`sed -n '$p' <<< "$stack"`

                case "$1" in
                    '+')
                        stack=`sed -e '$a'"$(($A + $B))" -e '/^$/d' -e '$d' \
                            <<< "$stack"`;;
                    '-')
                        stack=`sed -e '$a'"$(($A - $B))" -e '/^$/d' -e '$d' \
                            <<< "$stack"`;;
                    '*')
                        stack=`sed -e '$a'"$(($A * $B))" -e '/^$/d' -e '$d' \
                            <<< "$stack"`;;
                    '/')
                        stack=`sed -e '$a'"$(($A / $B))" -e '/^$/d' -e '$d' \
                            <<< "$stack"`;;
                    
                esac
            else
                echo "Unknown RPN token \`\`$1''"
            fi
        fi
        echo "$1" ":" $stack
        shift
    done
    
    sed -n '1p' <<< "$stack"
    if [ "`wc -l <<< "$stack"`" -gt 1 ]; then
        echo "Strange input expression" > /dev/stderr
        return 1
    else
        return 0
    fi
}