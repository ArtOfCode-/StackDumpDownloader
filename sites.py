import requests
import requests.exceptions
from xml.etree import ElementTree

sitelist_file = "http://archive.org/download/stackexchange/Sites.xml"

def get_site_list():
    print("[sites] Downloading site data XML file...")
    try:
        response = requests.get(sitelist_file)
    except requests.exceptions.SSLError as ex:
        print("[sites] Download failed because of an SSL error: {0}".format(ex))
        return []
    except requests.exceptions.BaseHTTPError as ex:
        print("[sites] Download failed because of an HTTP error: {0}".format(ex))
        return []
    except requests.exceptions.ConnectionError as ex:
        print("[sites] Download failed because of a connection error: {0}".format(ex))
        return []
    xml_tree = ElementTree.fromstring(response.content)
    return parse_tree(xml_tree)


def parse_tree(tree):
    print("[sites] Processing XML, forming list...")
    sites = []
    for site_node in tree:
        sites.append(site_node.attrib)
    return sites
