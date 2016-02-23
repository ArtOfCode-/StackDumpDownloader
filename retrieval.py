import os
import os.path as path
import subprocess
import urllib.request as urllib


class StackDataRetriever:
    def __init__(self, site, data_dir):
        self.site = site
        self.site_name = self.site['TinyName']
        self.site_hostname = self.site['Url'].split("//")[-1]
        self.data_dir = data_dir
        self.url = "https://archive.org/download/stackexchange/{0}.7z".format(self.site_hostname)

    def retrieve(self):
        filename = self._download_to_file(self.url, self.data_dir)
        site_dir = self.data_dir + self.site_name + "/"
        if not path.isdir(site_dir):
            os.mkdir(site_dir)
        self._decompress_to(site_dir, filename)
        return site_dir

    @staticmethod
    def _download_to_file(url, data_dir):
        filename = data_dir + url.split('/')[-1]
        print("[StackDataRetriever] Downloading {0} to {1}...".format(url, filename))
        urllib.urlretrieve(url, filename)
        return filename

    @staticmethod
    def _decompress_to(directory, filename):
        print("[StackDataRetriever] Decompressing {0} to {1} by delegation...".format(filename, directory))
        subprocess.call(r'"C:\\Program Files\\7-Zip\\7z.exe" x {0} -o{1}'.format(filename, directory))
