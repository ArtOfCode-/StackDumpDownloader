import os
import os.path as path
import shutil
import mysql.connector as mysql
from config import Config

def rm_files(data_file):
    print("[preops] Removing data files from previous run.")
    shutil.rmtree(data_file, ignore_errors=True)
    os.mkdir(data_file)

def ensure_data_dir(data_dir):
    if not path.isdir(data_dir):
        os.mkdir(data_dir)

def clear_db(tables):
    queries = []
    for table in tables:
        queries.append("TRUNCATE {0};".format(table))

    print("[preops] Clearing database: executing {0}".format(query))

    conn = mysql.connect(user=Config.Database['user'],
                         password=Config.Database['pass'],
                         host=Config.Database['host'],
                         database=Config.Database['name'])

    for query in queries:
        conn.cursor().execute(query)

    conn.commit()
    conn.cursor().close()
    conn.close()
