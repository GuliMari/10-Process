#!/bin/bash

# Делаем выборку по PID и сортируем по возрастанию
PROC=$(ls /proc | grep -E '^[0-9]+$' | sort -n)
echo "PID     TTY     STAT     TIME      COMMAND"

# TIME - время, затраченное процессом на использование CPU. Для расчета TIME мы суммируем utime и stime, затем делим на количество тактов процессора в секунду СLK_TCK, чтобы получить время, затраченное процессом на использование CPU в секундах.
ticks=$(getconf CLK_TCK)

for dir in $PROC; do
    pid=$dir
    # Скрипт выдавал ошибку, что некоторых директорий с какими-то PID не существует и останавливался, поэтому включила данное исключение:
    if [[ ! -e /proc/$dir ]]; then
      tty=n/a
      state=n/a
      cpu_time=n/a
      comm=n/a 
    # В остальных случаях данные находились в директории /proc/PID/stat
    else
    # Информация о TTY в /proc представлена в виде числа
      tty=$(awk '{print $7}' /proc/$dir/stat)     
      state=$(awk '{print $3}' /proc/$dir/stat) 
      utime=$(awk '{print $14}' /proc/$dir/stat)
      stime=$(awk '{print $15}' /proc/$dir/stat)
      total_cpu_time=$(($utime + $stime))
      cpu_time=$(($total_cpu_time / $ticks))
      minutes_cpu_time=$(("$cpu_time" / 60))
      seconds_cpu_time=$(("$cpu_time" % 60))
    # Командная строка может содержать символы нуля, которые нужно заменить на пробелы с помощью tr. 
      comm=$(cat /proc/$dir/cmdline | tr '\0' ' ' | cut -b -200)
      if [[ -z "$comm" ]]; then
        comm="[$(cat /proc/$dir/comm)]" 
      else  
        comm=$comm
      fi
    fi

    # Выводим информацию
    printf "%-8s %-7s %-5s %02d:%02d %-30s\n" "$pid" "$tty" "$state" "$minutes_cpu_time" "$seconds_cpu_time" "$comm"
done
