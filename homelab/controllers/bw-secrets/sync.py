from base64 import b64encode, b64decode
from http.server import BaseHTTPRequestHandler, HTTPServer

import json
import urllib.request


class Controller(BaseHTTPRequestHandler):
  def sync(self, parent, children):
    # Compute status based on observed state.
    desired_status = {
      "secrets": len(children["Secret.v1"])
    }

    # Generate the desired child object(s).
    item_id = parent.get("spec", {}).get("id", "d42cb757-a8ed-47d7-ab5e-af430133b868")
    desired_secrets = [
      {
        "apiVersion": "v1",
        "kind": "Secret",
        "type": "Opaque",
        "metadata": {
          "name": parent["metadata"]["name"],
          "namespace": parent["metadata"]["namespace"]
        },
        "data": {
          "secret": f"{b64encode('secret')}",
        }
      }
    ]

    #request = urllib.request.Request(f"http://127.0.0.1:8087/object/item/{item_id}")
    #with urllib.request.urlopn(request) as response:
    #  data = json.loads(response.read().decode("utf-8"))
    #  print(f"BW CLI request successful: {data['success']}")

    return {"status": desired_status, "children": desired_secrets}

  def do_POST(self):
    # Serve the sync() function as a JSON webhook.
    observed = json.loads(self.rfile.read(int(self.headers.get("content-length"))))
    desired = self.sync(observed["parent"], observed["children"])

    self.send_response(200)
    self.send_header("Content-type", "application/json")
    self.end_headers()
    self.wfile.write(json.dumps(desired).encode())

HTTPServer(("", 80), Controller).serve_forever()
