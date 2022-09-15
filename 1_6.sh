echo "введите первую директорию"
read dir1
echo "введите вторую директорию"
read dir2
#создаем два временных файла для хранения содержимого директорий (все имена файлов в папках)
ls $dir1 > Temp_File1
ls $dir2 > Temp_File2
#считаем количество файлов в каждой из директорий
lin1=`cat Temp_File1 | wc -l`
lin2=`cat Temp_File2 | wc -l`
#++++++++++++создаем пустые переменные
с=0
b=0
#первый цикл перечисляет файлы из первой папки
for i in $(seq 1 $lin1)
do
        #в переменную file1 будут присваивать имена файлов в первой директории
        file1=`sed -n $i"p" Temp_File1`
        #в переменную pathfile1 будут присваиваться полные пути к файлам из первой директории
        pathfile1=$dir1/$file1
        #второй цикл перечисляет файлы из второй папки
        for j in $(seq 1 $lin2)
        do
                #в переменную file2 будут присваивать имена файлов во второй директории
                file2=`sed -n $j"p" Temp_File2`
                #в переменную pathfile2 будут присваиваться полные пути к файлам из второй директории
                pathfile2=$dir2/$file2
                #переменная с считает количество сравнений файлов
                c=$(( $c + 1 ))
                #процесс сравнения файлов и удаление вывода команды как ненужной информации 
                diff $pathfile1 $pathfile2 > /dev/null
                #если предыдущая команда не показала различий файлов, выполняется вывод что такой-то файл из первой директории равен файлу из второй по содержимому
                if [ $? -eq 0 ] ; then
                        echo "$pathfile1 = $pathfile2"
                        #если полные пути к файлам не нужны - используй команду echo "$file1 = $file2"
                        #+++++++++++++подсчет количества совпадений
                        b=$(( $b + 1 ))
                fi
        done
done
#вывод количества сравнений
echo "$c сравнений"
#вывод количества файлов в обеих директориях
echo "$(( $lin1 + $lin2 )) файлов"
#++++++++++++++вывод количества совпадений
echo "$b совпадений"
#удаление временных файлов
rm -f Temp_File1 Temp_File2