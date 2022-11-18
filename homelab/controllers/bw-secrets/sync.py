from base64 import b64encode, b64decode
from http.server import BaseHTTPRequestHandler, HTTPServer

import json
import urllib.request


class Controller(BaseHTTPRequestHandler):
    def encode(self, secret):
        return b64encode(str(secret).encode("utf-8")).decode("utf-8")

    def sync(self, parent, children):
        # Compute status based on observed state.
        desired_status = {"secrets": len(children["Secret.v1"])}

        # This might need to be moved to a cronjob if we don't want to sync
        # every minute for every secret
        # request = urllib.request.Request(f"http://127.0.0.1:8087/sync", method="POST")
        # with urllib.request.urlopen(request) as response:
        #     pass

        # Generate the desired child object(s).
        item_id = parent.get("spec", {}).get(
            "id", "00000000-0000-0000-0000-000000000000"
        )

        request = urllib.request.Request(f"http://127.0.0.1:8087/object/item/{item_id}")
        with urllib.request.urlopen(request) as response:
            data = json.loads(response.read().decode("utf-8"))

        if data["success"]:
            desired_secrets = [
                {
                    "apiVersion": "v1",
                    "kind": "Secret",
                    "type": "Opaque",
                    "metadata": {"name": parent["metadata"]["name"]},
                    "data": {
                        secret["name"]: self.encode(secret["value"])
                        for secret in data["data"]["fields"]
                    },
                }
            ]

            return {"status": desired_status, "children": desired_secrets}
        else:
            self.log_error("Item couldn't be found")
            return {"status": desired_status, "children": []}

    def do_POST(self):
        # Serve the sync() function as a JSON webhook.
        observed = json.loads(self.rfile.read(int(self.headers.get("content-length"))))
        desired = self.sync(observed["parent"], observed["children"])

        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(desired).encode())


HTTPServer(("", 80), Controller).serve_forever()
