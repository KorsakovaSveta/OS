#! usr/bin/bash
echo "Введите первую директорию:"
read papka1
echo "Введите вторую директорию:"
read papka2
ls $papka1 > file_names1
ls $papka2 > file_names2
number1=`cat file_names1 | wc -l`
number2=`cat file_names2 | wc -l`
for i in $(seq 1 $number1);do
file1=`sed -n $i"p" file_names1`;
	for j in $(seq 1 $number2);do
	file2=`sed -n $j"p" file_names2`
	c=$(( $c + 1 ))
	diff "$papka1/$file1" "$papka2/$file2" > /dev/null
	if [ $? -eq 0 ] ; then
		echo "$file1 = $file2"
		b=$(( $b + 1 ))
	fi
	done
done
echo "$c сравнений"
echo "$(( $number1 + $number2 )) файлов"
echo "$b совпадений"
rm -f file_names1 file_names2