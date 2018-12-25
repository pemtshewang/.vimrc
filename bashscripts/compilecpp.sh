#!/bin/bash
#usage compile filename.cpp time(in sec)
#example compile main.cpp 1

echo -e "____________welcome mr.convict______________"
if
  g++ -std=gnu++14 -Wall -g -Wextra -Wshadow -Wfloat-equal -Wconversion -Wshift-overflow=2 -Wduplicated-cond -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=signed-integer-overflow -fsanitize=bounds -O2 -DCONVICTION $1
then
  echo -e "\e[32m\e[1mCompilation Successful!\e[0m"
  INPUT_NAME=input
  OUTPUT_NAME=my_output
  REALOUTPUT_NAME=output
  if [ -f "input1" ];
  then
	 echo -e "Input files exist."
	 for test_file in $INPUT_NAME*
	 do
		i=$((${#INPUT_NAME}))
		test_case=${test_file:$i}
		echo -e "____________________________________________\e[93m"
		echo -e "\t\e[1mSample Test case: $test_case\e[0m\e[93m"
		if timeout $2 /usr/bin/time --format="\tMemory Used  : %M kb\n\tTime Elapsed : %e sec" ./a.out < $INPUT_NAME$test_case > $OUTPUT_NAME$test_case ; then
		  echo -e "\e[0m"
		  cat $OUTPUT_NAME$test_case
		else
		  echo -e "\e[91m\e[1m\tTime Limit Exceeded! \e[0mAllowed : $2s"
		fi
	 done
	 if [ -f "output1" ]; then
		echo -e "==================VERDICT==================="
		for test_file in $INPUT_NAME*
		do
		  i=$((${#INPUT_NAME}))
		  test_case=${test_file:$i}
		  if diff --brief --ignore-trailing-space $REALOUTPUT_NAME$test_case $OUTPUT_NAME$test_case >> errlg; then
			 echo -e "\e[1m\e[32m\tSample test $test_case: Accepted\e[0m"
		  else
			 echo -e "\e[1m\e[31m\tSample test $test_case: Wrong Answer\e[0m"
		  fi
		done
	 fi

  else
	 echo -e "Input files doesn't exist. Please enter input MANUALLY. TLE won't be identified."
	 echo -e " "
	 ./a.out > out
	 cat out
	 echo -e "____________________________________________"
  fi

else
  echo -e "\e[91m\e[1mCompilation Error!\e[0m";
fi
echo -e "____________________________________________"
