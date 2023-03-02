# Домашнее задание

- Написать свою реализацию ps ax используя анализ /proc
  Результат ДЗ - рабочий скрипт который можно запустить

# Выполнение
Сравнение вывода команды `ps -ax` и скрипта:

```bash
tw4@tw4-mint:~/Desktop/Linux/Pro/10-Процессы$ ps -ax | head -10
    PID TTY      STAT   TIME COMMAND
      1 ?        Ss     0:04 /sbin/init splash
      2 ?        S      0:00 [kthreadd]
      3 ?        I<     0:00 [rcu_gp]
      4 ?        I<     0:00 [rcu_par_gp]
      5 ?        I<     0:00 [slub_flushwq]
      6 ?        I<     0:00 [netns]
      8 ?        I<     0:00 [kworker/0:0H-events_highpri]
     10 ?        I<     0:00 [mm_percpu_wq]
     11 ?        S      0:00 [rcu_tasks_rude_]
tw4@tw4-mint:~/Desktop/Linux/Pro/10-Процессы$ ./ps.sh  | head -10
PID     TTY     STAT     TIME      COMMAND
1        0       S     00:04 /sbin/init splash             
2        0       S     00:00 [kthreadd]                    
3        0       I     00:00 [rcu_gp]                      
4        0       I     00:00 [rcu_par_gp]                  
5        0       I     00:00 [slub_flushwq]                
6        0       I     00:00 [netns]                       
8        0       I     00:00 [kworker/0:0H-events_highpri] 
10       0       I     00:00 [mm_percpu_wq]                
11       0       S     00:00 [rcu_tasks_rude_]            
```
