import psycopg2
from pprint import pprint

def create_tables(cur):
    #Создание таблицы клиентов
    cur.execute("""
    CREATE TABLE IF NOT EXISTS clients_HW_5(
    id SERIAL PRIMARY KEY, 
    client_name VARCHAR(100) NOT NULL, 
    client_surname VARCHAR(100) NOT NULL, 
    client_email VARCHAR(100) NOT NULL
    );
    """)
    #Создание таблицы с клиентскими номерами
    cur.execute("""
    CREATE TABLE IF NOT EXISTS client_phonenumbers(
    id_phonenumber SERIAL PRIMARY KEY,
    client_id INTEGER NOT NULL REFERENCES clients_HW_5(id),
    client_phonenumber VARCHAR(20) UNIQUE);
    """)



def add_new_client(cur, client_name, client_surname, client_email):
    #Добавление нового клиента в таблицу clients_HW_5
    cur.execute("""
    INSERT INTO clients_HW_5(client_name, client_surname, client_email) VALUES(%s, %s, %s);
    """, (client_name, client_surname, client_email))



def add_new_phonenumber(cur, client_id, phonenumber):
    #Добавление нового номера телефона в таблицу client_phonenumbers
    cur.execute("""
    INSERT INTO client_phonenumbers(client_id, client_phonenumber) VALUES(%s, %s);
    """, (client_id, phonenumber))



def change_client_data():
    #Изменение информации о клиенте
    print("Для изменения информации о клиенте, введите команду.\n "
        "1 - изменить имя клиента; 2 - изменить фамилию клиента; 3 - изменить e-mail клиента; 4 - изменить номер телефона клиента")

    while True:
        command_symbol = int(input())
        if command_symbol == 1:
            input_id_for_changing_name = input("Введите id клиента имя которого хотите изменить: ")
            input_name_for_changing = input("Введите новое имя: ")
            cur.execute("""
            UPDATE clients_HW_5 SET client_name=%s WHERE id=%s;
            """, (input_name_for_changing, input_id_for_changing_name))
            break
        elif command_symbol == 2:
            input_id_for_changing_surname = input("Введите id клиента фамилию которого хотите изменить: ")
            input_surname_for_changing = input("Введите новую фамилию: ")
            cur.execute("""
            UPDATE clients_HW_5 SET client_surname=%s WHERE id=%s;
            """, (input_surname_for_changing, input_id_for_changing_surname))
            break
        elif command_symbol == 3:
            input_id_for_changing_email = input("Введите id клиента e-mail которого хотите изменить: ")
            input_email_for_changing = input("Введите новый e-mail: ")
            cur.execute("""
            UPDATE clients_HW_5 SET client_email=%s WHERE id=%s;
            """, (input_email_for_changing, input_id_for_changing_email))
            break
        elif command_symbol == 4:
            input_phonenumber_you_wanna_change = input("Введите номер телефона который нужно изменить: ")
            input_phonenumber_for_changing = input("Введите новый номер телефона: ")
            cur.execute("""
            UPDATE client_phonenumbers SET client_phonenumber=%s WHERE client_phonenumber=%s;
            """, (input_phonenumber_for_changing, input_phonenumber_you_wanna_change))
            break
        else:
            print("Вы ввели неправильную команду, повторите ввод!")

def delete_client_phonenumber():
    #Удаление номера телефона из таблицы client_phonenumbers
    input_id_for_deleting_phonenumber = input("Введите id клиента номер телефона которого хотите удалить: ")
    input_phonenumber_for_deleting = input("Введите номер телефона который хотите удалить: ")
    with conn.cursor() as cur:
        cur.execute("""
        DELETE FROM client_phonenumbers WHERE client_id=%s AND client_phonenumber=%s
        """, (input_id_for_deleting_phonenumber, input_phonenumber_for_deleting))

def delete_client():
    #Удаление клиента
    input_id_for_deleting_client = input("Введите id клиента которого хотите удалить: ")
    input_client_surname_for_deleting = input("Введите фамилию клиента которого хотите удалить: ")
    with conn.cursor() as cur:
        #удаление связи с таблицей client_phonenumbers
        cur.execute("""
        DELETE FROM client_phonenumbers WHERE client_id=%s
        """, (input_id_for_deleting_client,))
        #удаление клиента из таблицы clients_HW_5
        cur.execute("""
        DELETE FROM clients_HW_5 WHERE id=%s AND client_surname=%s
        """, (input_id_for_deleting_client, input_client_surname_for_deleting))

def find_client():
    #Поиск клиента по имени
    print("Для поиска клиента, введите команду:\n "
          "1 - найти по имени; 2 - найти по фамилии; 3 - найти по e-mail; 4 - найти по номеру телефона")
    while True:
        input_command_for_finding = int(input("Введите команду для поиска клиента: "))
        if input_command_for_finding == 1:
            input_name_for_finding = input("Введите имя клиента: ")
            cur.execute("""
            SELECT id, client_name, client_surname, client_email, client_phonenumber
            FROM clients_HW_5 AS ch5
            LEFT JOIN client_phonenumbers AS cp ON cp.id_phonenumber = ch5.id
            WHERE client_name=%s
            """, (input_name_for_finding,))
            print(cur.fetchall())
        elif input_command_for_finding == 2:
            input_surname_for_finding = input("Введите фамилию клиента: ")
            cur.execute("""
            SELECT id, client_name, client_surname, client_email, client_phonenumber
            FROM clients_HW_5 AS ch5
            LEFT JOIN client_phonenumbers AS cp ON cp.id_phonenumber = ch5.id
            WHERE client_surname=%s
            """, (input_surname_for_finding,))
            print(cur.fetchall())
        elif input_command_for_finding == 3:
            input_email_for_finding = input("Введите email клиента: ")
            cur.execute("""
            SELECT id, client_name, client_surname, client_email, client_phonenumber
            FROM clients_HW_5 AS ch5
            LEFT JOIN client_phonenumbers AS cp ON cp.id_phonenumber = ch5.id
            WHERE client_email=%s
            """, (input_email_for_finding,))
            print(cur.fetchall())
        elif input_command_for_finding == 4:
            input_phonenumber_for_finding = input("Введите номер телефона клиента: ")
            cur.execute("""
            SELECT id, client_name, client_surname, client_email, client_phonenumber
            FROM clients_HW_5 AS ch5
            LEFT JOIN client_phonenumbers AS cp ON cp.id_phonenumber = ch5.id
            WHERE client_phonenumber=%s
            """, (input_phonenumber_for_finding,))
            print(cur.fetchall())
        else:
            print("Вы ввели неправильную команду, повторите ввод!")

def check_function(cur):
    #Проверочная функция, отображает содержимое таблиц
    cur.execute("""
    SELECT * FROM clients_HW_5;
    """)
    pprint(cur.fetchall())
    cur.execute("""
    SELECT * FROM client_phonenumbers;
    """)
    pprint(cur.fetchall())


with psycopg2.connect(database="netology_db", user="postgres", password="***") as conn:
    with conn.cursor() as cur:
        create_tables(cur)
        check_function(cur)
        add_new_client(cur, "Ivan", "Ivanov", "ivanov@mail.ru")
        add_new_client(cur, "Petr", "Petrov", "petrov@mail.ru")
        add_new_client(cur, "Pavel", "Pavlov", "pavlov@mail.ru")
        add_new_client(cur, "Alex", "Alekseev", "alekseev@mail.ru")
        add_new_client(cur, "Boris", "Borisov", "borisov@mail.ru")
        add_new_phonenumber(cur, 1, "9051235476")
        add_new_phonenumber(cur, 2, "9063214567")
        add_new_phonenumber(cur, 3, "9109875634")
        add_new_phonenumber(cur, 4, "9163457865")
        add_new_phonenumber(cur, 5, "9031357986")
        change_client_data()
        delete_client_phonenumber()
        delete_client()
        find_client()

conn.close()