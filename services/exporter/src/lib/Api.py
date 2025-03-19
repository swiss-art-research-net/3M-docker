
from lxml import etree
from pyexistdb import db

class Api:

    def __init__(self, db_endpoint):
        self.db_endpoint = db_endpoint