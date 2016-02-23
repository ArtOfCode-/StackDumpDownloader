import mysql.connector as mysql
from xml.etree import ElementTree
import os.path as path


class Config:
    Database = {
        "host": "localhost",
        "user": "DataManager",
        "pass": "JMNDXAHJPVfwyfZ4",
        "name": "StackData"
    }


class FileProcessor:
    def __init__(self, file):
        self.file = file
        self.site = file.split("/")[-2]
        self.conn = self._get_db_conn()

    @staticmethod
    def _get_db_conn():
        return mysql.connect(user=Config.Database['user'],
                             password=Config.Database['pass'],
                             host=Config.Database['host'],
                             database=Config.Database['name'])

    def _clean_up(self):
        self.conn.commit()
        self.conn.cursor().close()
        self.conn.close()

    def process(self):
        # TODO: We still get the odd MySQL syntax error. Investigate what else can be done.
        # We'll assume that we're getting sane data in. Bad assumption, I know, but I really can't be
        # bothered to work in all the edge cases that are possible here. I'm assuming a filename of the form
        # TableName.xml.
        file_name = path.basename(self.file)
        table_name = file_name.split(".")[0]
        successful_queries = 0
        failed_queries = 0
        with open(self.file, encoding='utf-8') as f:
            try:
                xml_tree = ElementTree.fromstring(u"\n".join(f.readlines()[1:]))
            except Exception as ex:
                print("[FileProcessor] Failed to create XML tree: {0}".format(ex))
                return
        for node in xml_tree:
            value_names = []
            values = []
            for k, v in node.attrib.items():
                val = self.conn.converter.escape(v)
                if k == "Id":
                    value_names.append(u"`SiteSpecificId`")
                    values.append(u"'{0}'".format(val))
                else:
                    value_names.append(u"`" + k + "`")
                    values.append(u"'{0}'".format(val))

            value_names.append("`Site`")
            values.append(u"'{0}'".format(self.site))

            value_names.append("`Id`")
            values.append("DEFAULT")

            query = u"INSERT INTO `{0}` ({1}) VALUES ({2});"\
                    .format(table_name, ", ".join(value_names), ", ".join(values))

            try:
                self.conn.cursor().execute(query)
                successful_queries += 1
            except mysql.Error as ex:
                failed_queries += 1
                print(u"[FileProcessor] Query failed: {0}".format(ex))
                if str(ex)[0:4] == "1064":
                    try:
                        print(u"[FileProcessor] {0}".format(query))
                    except UnicodeEncodeError:
                        print("[FileProcessor] Avoiding printing query due to UEE.")
                        
        print("[FileProcessor] Processed file {0} with {1} successful queries and {2} failed."
              .format(file_name, successful_queries, failed_queries))
        self._clean_up()
