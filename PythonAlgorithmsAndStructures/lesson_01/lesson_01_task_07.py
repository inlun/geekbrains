# 7. Определить, является ли год, который ввел пользователь, високосным или не високосным.

a = int(input("Введите год: "))
if (a % 400 == 0) | ((a % 4 == 0) & (a % 100 != 0)):
    print("Год високосный")
else:
    print("Год не високосный")