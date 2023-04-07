# second_task_data_usage

## drift и firebase: 
в data/repositories есть репозитории `DriftTaskRepository` и `FirestoreTaskRepository` их можно вставить в MyApp -> TaskBloc для проверки каждого из них <br>
на данный момент используется `FirestoreTaskRepository`

## результат
![65](https://user-images.githubusercontent.com/47796424/230577394-86f8f5bd-c81e-444d-b991-4df15433e977.gif)
![66](https://user-images.githubusercontent.com/47796424/230579858-46e0ff5c-6d35-43e9-b516-1184b29ced0c.gif)

## структура папок:
+ assets - ресурсы проекта
+ data - слой данных
++ datasourses - бд проекта
++ repositories - репозитории проекта
+ domain - слой бизнесс логики
++ blocs - блоки проекта
++ models - сущности проекта
++ repositories - интерфейсы проекта
+ presentation - слой представления
++ ui - ui проекта
+++ screens - экраны проекта
+++ widgets - виджеты проекта 
+ utils 
