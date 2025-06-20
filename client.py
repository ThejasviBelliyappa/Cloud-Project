import requests
import cv2
import base64
import json
import time

im = cv2.imread("test_image.jpeg")
if im is None:
    raise FileNotFoundError("Image file not found. Ensure 'test_image.jpeg' exists in container.")
im = cv2.resize(im, dsize=(256, 256), interpolation=cv2.INTER_CUBIC)
encoded = base64.b64encode(cv2.imencode(".jpeg",im)[1].tobytes()).decode("utf-8")

t = time.perf_counter()
response = requests.post("http://server:8001/infer", data=json.dumps({"data": encoded}))
print(response.text, round(time.perf_counter() - t, 3))