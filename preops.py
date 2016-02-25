import os
import os.path as path
import shutil
import mysql.connector as mysql
from config import Config

def rm_files(data_file):
    shutil.rmtree(data_file, ignore_errors=True)
    os.mkdir(data_file)

def ensure_data_dir(data_dir):
    if not path.isdir(data_dir):
        os.mkdir(data_dir)

def clear_db(tables):
    query = ""
    for table in tables:
        query += "TRUNCATE {0};".format(table)

    conn = mysql.connect(user=Config.Database['user'],
                         password=Config.Database['pass'],
                         host=Config.Database['host'],
                         database=Config.Database['name'])
    conn.cursor().execute(query)
    conn.commit()
    conn.cursor().close()
    conn.close()
