ms() {
  rows=$1
  shift
  cols=$1
  shift

  declare -A mines

  for x ; do 
    mines[$x]=1
  done
  for row in $(seq 0 $[$rows - 1]) ; do
    for col in $(seq 0 $[$cols - 1]) ; do
      if [ "${mines["${row},${col}"]}" == 1 ] ; then
        printf '*'
      else
        printf $[ \
            ${mines[$[$row - 1],$col]:-0} \
          + ${mines[$[$row + 1],$col]:-0} \
          + ${mines[$[$row + 1],$[$col - 1]]:-0} \
          + ${mines[$[$row + 1],$[$col + 1]]:-0} \
          + ${mines[$[$row - 1],$[$col - 1]]:-0} \
          + ${mines[$[$row - 1],$[$col + 1]]:-0} \
          + ${mines[$row,$[$col - 1]]:-0} \
          + ${mines[$row,$[$col + 1]]:-0} \
        ]
      fi
    done
    printf ' '
  done

# if [ $cols == 2 ] ; then
#   if [ $rows == 1 ] ; then
#     echo '*1'
#   else
#     if [ ${2} ] ; then
#       echo "** 22"
#     elif [ ${1::1}  == 0 ] ; then
#       echo "1* 11"
#     else 
#       echo "11 1*"
#     fi
#   fi
# elif [ $1 ] ; then
#   echo '*'
# else
#   echo '0'
# fi
}

# $()  chamada de comandos
# $[]  matemática
# ${}  acesso à variável


describe "Minesweeper tests"

it_1x1_1mine() {
  result="$(ms 1 1 0,0)"
  expected="* "
  test "$result" == "$expected"
}

it_1x1_0mine() {
  result="$(ms 1 1)"
  expected="0 "
  test "$result" == "$expected"
}

it_1x2_1mine() {
  result="$(ms 1 2 0,0)"
  expected="*1 "
  test "$result" == "$expected"
}

it_2x2_1mine() {
  result="$(ms 2 2 1,1)"
  expected="11 1* "
  test "$result" == "$expected"
}

it_2x2_1mine_01() {
  result="$(ms 2 2 0,1)"
  expected="1* 11 "
  test "$result" == "$expected"
}

it_2x2_2mine_00_01() {
  result="$(ms 2 2 0,0 0,1)"
  expected="** 22 "
  test "$result" == "$expected"
}

it_4x4_2mine_example_description() {
  result="$(ms 4 4 0,0 2,1)"
  expected="*100 2210 1*10 1110 "
  test "$result" == "$expected"
}

