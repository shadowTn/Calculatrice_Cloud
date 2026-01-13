from flask import Flask, request, jsonify
import pika, redis, uuid, json

app = Flask(__name__)

redis_db = redis.Redis(host="redis", port=6379, decode_responses=True)

@app.route("/api/operation", methods=["POST"])
def operation():
    data = request.get_json()

    a = float(data["first_element"])
    b = float(data["second_element"])
    op = data["operation"]

    job_id = str(uuid.uuid4())
    connection = pika.BlockingConnection(pika.ConnectionParameters(host="rabbitmq"))
    channel = connection.channel()
    channel.queue_declare(queue="calc_queue")

    message = {"id": job_id, "a": a, "b": b, "op": op}
    channel.basic_publish(exchange="", routing_key="calc_queue", body=json.dumps(message))

    connection.close()

    return jsonify({"id": job_id})


@app.route("/api/result/<job_id>", methods=["GET"])
def result(job_id):
    val = redis_db.get(job_id)

    if val is None:
        return jsonify({"error": "not found"}), 404

    return jsonify({"status": "done", "result": val})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
