import pymysql
from config import HOST, USER, PASSWD, DB_NAME
from Lesson3_querys import *
from Lesson2_querys import *


"""Work with MySQL. Using CRUD principles."""


def print_table(table: set):
    for row in table:
        print(row)


try:
    connection = pymysql.connect(host=HOST,
                                 user=USER,
                                 port=3306,
                                 password=PASSWD,
                                 database=DB_NAME,
                                 cursorclass=pymysql.cursors.DictCursor

                                 )
    print("Access granted.")
    try:
        cursor = connection.cursor()

        # Lesson 3
        cursor.execute(create_query)
        cursor.execute(insert_query)
        connection.commit()
        cursor.execute(update_query)
        connection.commit()
        cursor.execute(delete_query)
        connection.commit()
        cursor.execute(select_query)
        rows = cursor.fetchall()
        print_table(rows)

        print("Lesson 2 begin. Create new db.")
        # Lesson 2
        cursor.execute(create_db)
        connection.commit()
        cursor.execute(use_db)
        connection.commit()
        cursor.execute("DROP TABLE IF EXISTS movie;")
        connection.commit()
        cursor.execute(create_table)
        connection.commit()
        cursor.execute(insert_movies)
        connection.commit()
        cursor.execute(add_column)
        connection.commit()
        cursor.execute(select_all_movie)
        rows = cursor.fetchall()
        print("\n\nPrint all from movie table of Lesson2.db.\n")
        print_table(rows)
        cursor.execute(drop_column)
        print()
        cursor.execute(describe_table)
        rows = cursor.fetchall()
        print_table(rows)
        print()
        cursor.execute(add_category_clmn)
        connection.commit()
        cursor.execute(set_rand_val)
        connection.commit()
        cursor.execute(select_w_case)
        rows = cursor.fetchall()
        print_table(rows)
    finally:
        connection.close()
except Exception as ex:
    print("Cant connect to bd\n{0}".format(ex))
