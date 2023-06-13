# create
create_query = "CREATE TABLE IF NOT EXISTS test1(" \
               "id INT PRIMARY KEY AUTO_INCREMENT," \
               "name VARCHAR(20));"

# insert
insert_query = "INSERT test1 (name)" \
               "VALUES ('Anton'), ('Aleksandr');"

# update
update_query = "UPDATE test1 SET name = 'Mike' WHERE id = 2;"

# delete
delete_query = "DELETE FROM test1 WHERE id = 1;"

# select
select_query = "SELECT * FROM test1;"
