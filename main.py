import os
import os.path as path
import sys
import shutil

import sites
import preops
from retrieval import StackDataRetriever
from processing import FileProcessor


site_whitelist = ['Programming Puzzles and Code Golf', 'Code Review', 'Motor Vehicle Maintenance and Repair']
site_blacklist = []

site_mode = "whitelist"

data_dir = (os.getcwd() + "/" if os.getcwd()[-1] != "/" else os.getcwd()) + "data/"


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
    if site_mode == 'whitelist':
        trimmed = [x for x in site_list if x['Name'] in site_whitelist]
    elif site_mode == 'blacklist':
        trimmed = [x for x in site_list if x['Name'] not in site_blacklist]
    else:
        trimmed = []
    return trimmed


if __name__ == "__main__":
    if "-X" in sys.argv:
        preops.rm_files()
    if "-C" in sys.argv:
        preops.clear_db()
    preops.ensure_data_dir()
    main()
