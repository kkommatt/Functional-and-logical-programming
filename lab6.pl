student(юрій, кну, історичний, відмінний).
student(юлія, кну, фізичний, добрий).
student(юлій, кпі, технічний, задовільний).
student(юстиніан, наукма, гуманітарний, добрий).
student(юпітер, кпі, юридичний, відмінний).
student(юхим, нубіп, біологічний, задовільний).
student(юстина, кнукім, мистецький, добрий).
student(юліан, нау, математичний, добрий).

find_student :-
    write('Введіть університет: '), read(University),
    write('Введіть факультет: '), read(Faculty),
    write('Введіть рівень навчання: '), read(Level),
    student(FirstName, University, Faculty, Level),
    write('Результат: '), write(FirstName), 
    nl.

find_student :-
    write('Жодного студента за такими критеріями не знайдено'), 
    nl.