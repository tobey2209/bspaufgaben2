#!/bin/bash
# The first shell script
# <Tobias.Nguyen>
# <6.04.23>

mkdir results
rm -rf results
#Varibalen
 seed_value_list="2806 225 353"
 page_size_list=(8 16 32 64)
 page_rep_algo_list="FIFO CLOCK AGING"
 search_algo_list="quicksort bubblesort"

 index=0
 for sizeList_value in "${page_size_list[@]}"

 do

   echo"$sizeList_value"
   gcc  -DVMEM_PAGESIZE="$sizeList_value" -DSTOP_BEFORE_END -o p1 mockup.c
    gcc -DVMEM_PAGESIZE="$sizeList_value" -o p2 mockup.c
    for seed_value in "${seed_value_list[@]}"
    do
      for page_value in "${page_rep_algo_list[@]}"
      do
        for search_value in "${search_algo_list[@]}"
        do
             echo "$seed_value $page_value $search_value"
                #varibale an den formalen Parameter übergeben
                                #ID holen
             ./p1 "$page_value" & p1_id=$$
             sleep 1
             ./p2 -seed="$seed_value"-"$search_value" > results/output_"$seed_value" "$search_value" "$search_value" "$sizeList_value"
             kill -s KILL p1_id
             wait $p1_id > /dev/null
        done
      done
    done
done

