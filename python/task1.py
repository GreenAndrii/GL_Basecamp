"""Создать функцию count_holes(value), которая принимает аргумент value - 
целое число или строка содержащая целое число.
Функция возвращает целое число - количество "отверстий" (смотри рисунок) 
в записи этого числа, или строку 'error', если переданый аргумент не 
удовлетворяет требованиям: число не целое или вообще не является числом. 
Нули в начале записи числа не учитывать, если таковые имеются.
"""
from re import match


def count_holes():
    count = 0
    numbers = input("Enter number: ")
    result = match(r'^0*([0-9]+)$', numbers)
    if result:
        for i in result.group(1):
            if int(i) in [4, 6, 9, 0, ]:
                count += 1
            elif int(i) == 8:
                count += 2
        return count
    else:
        return "Error: please, enter an integer number"


print(count_holes())
