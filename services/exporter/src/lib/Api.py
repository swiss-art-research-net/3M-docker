"""
Class to interact with the eXist-db API

Usage:
    api = Api("http://editor:8081/exist")
    mapping = api.get(1)
"""


from lxml import etree
from pyexistdb import db

class Api:

    def __init__(self, endpoint, *, user="admin", password="admin"):
        self.existdb = db.ExistDB(endpoint, user, password)

    def get(self, mapping_id: int):
        xquery = f"""
        xquery version "3.0";
        doc("/db/DMSCOLLECTION/3M/Mapping/1/Mapping{mapping_id}.xml")
        """
        # Execute the XQuery
        response = self.existdb.query(xquery)

        try:
            root = response.results[0]
        except IndexError:
            raise ValueError("Mapping not found")

        # We want to retain only the namespaces and mappings
        namespaces = root.find("namespaces")
        mappings = root.find("mappings")

        # Add the namespaces in the target
        namespacesTarget = root.find(".//target/target_info/namespaces")
        if namespacesTarget is not None:
            namespaces.extend(namespacesTarget)

        # Create a new root element
        newRoot = etree.Element("x3ml")

        # Add the attributes from the original root to the new root
        for key, value in root.attrib.items():
            newRoot.set(key, value)

        # Add the namespaces and mappings to the new root
        newRoot.append(namespaces)
        newRoot.append(mappings)
        return etree.tostring(newRoot, pretty_print=True)