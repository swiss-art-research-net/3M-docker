"""

"""

import os
from fastapi import FastAPI
from fastapi.responses import Response, HTMLResponse
from fastapi.middleware.cors import CORSMiddleware

from lib.Api import Api

app = FastAPI()

# Allow all origins to access your API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Inititialise parameters
DB_ENDPOINT = "http://editor:8081"

api = Api(DB_ENDPOINT)

@app.get("/", response_class=HTMLResponse)
def readRoot():
    return """
    <html>
        <head>
            <title>3M Mapping Exporter Service</title>
        </head>
        <body>
            <h1>3M Mapping Exporter Service</h1>
            <p>Use the following URL to retrieve a data export:</p>
            <pre>/export/{mapping_id}</pre>
        </body>
    </html>"""

@app.get("/export/{mapping_id}")
def get(mapping_id: str):
    content = api.get(mapping_id)
    return Response(content=content, media_type="application/xml")