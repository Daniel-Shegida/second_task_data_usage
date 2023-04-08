# second_task_data_usage

## Drift и Firebase: 
в data/repositories есть репозитории `DriftTaskRepository` и `FirestoreTaskRepository` их можно вставить в MyApp -> TaskBloc для проверки каждого из них <br>
на данный момент используется `FirestoreTaskRepository`


## Дополнительные задачи: 
+ добавить routmaster
+ добавить анимации слайдов как в телеграмме

## Результат
![65](https://user-images.githubusercontent.com/47796424/230577394-86f8f5bd-c81e-444d-b991-4df15433e977.gif) <br>
Перезагрузка  <br>
![66](https://user-images.githubusercontent.com/47796424/230579858-46e0ff5c-6d35-43e9-b516-1184b29ced0c.gif)<br>
дополнительные анимации  <br>
![68](https://user-images.githubusercontent.com/47796424/230740213-206f518c-45e0-4c30-82aa-0586f9199d6b.gif)


## Структура папок:
+ assets - ресурсы проекта
+ data - слой данных
  + datasourses - бд проекта
  + repositories - репозитории проекта
+ domain - слой бизнесс логики
  + blocs - блоки проекта
  + models - сущности проекта
  + repositories - интерфейсы проекта
+ presentation - слой представления
  + ui - ui проекта
    + screens - экраны проекта
    + widgets - виджеты проекта 
+ utils 

## Lints
а еще добавлено `require_trailing_commas` так что с запятыми все нормально
