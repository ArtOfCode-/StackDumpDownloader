import os
import os.path as path
import sys
import shutil

import sites
import preops
from retrieval import StackDataRetriever
from processing import FileProcessor

data_dir = (os.getcwd() + "/" if os.getcwd()[-1] != "/" else os.getcwd()) + "data/"

data_tables = ['Badges', 'Comments', 'PostHistory', 'PostLinks', 'Posts', 'Tags', 'Users', 'Votes']


def main():
    site_list = trim_site_list(sites.get_site_list())
    print("[MAIN] Sites: {0}".format(", ".join([x['Name'] for x in site_list])))
    for site in site_list:
        print("[MAIN] Processing site: {0}".format(site['Name']))
        print("[MAIN] Retrieving data...")
        retriever = StackDataRetriever(site, data_dir)
        site_dir = retriever.retrieve()
        files = [os.path.join(site_dir, fn) for fn in next(os.walk(site_dir))[2]]
        print("[MAIN] Processing extracted XML to database...")
        for file in files:
            processor = FileProcessor(file)
            processor.process()


def trim_site_list(site_list):
    if Config.General['site_mode'] == 'whitelist':
        trimmed = [x for x in site_list if x['Name'] in Config.General['site_whitelist']]
    elif Config.General['site_mode'] == 'blacklist':
        trimmed = [x for x in site_list if x['Name'] not in Config.General['site_blacklist']]
    else:
        trimmed = []
    return trimmed


if __name__ == "__main__":
    if "-X" in sys.argv:
        preops.rm_files(data_dir)
    if "-C" in sys.argv:
        preops.clear_db(data_tables)
    preops.ensure_data_dir(data_dir)
    main()
