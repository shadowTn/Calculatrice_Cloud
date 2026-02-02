import pika
import redis
import json
import sys
import os

# Redis container name = "redis"
redis_db = redis.Redis(host='redis', port=6379, decode_responses=True)

def main():
    # RabbitMQ container name = "rabbitmq"
    connection = pika.BlockingConnection(
        pika.ConnectionParameters(host='rabbitmq', port=5672)
    )
    channel = connection.channel()

    channel.queue_declare(queue='calc_queue')

    def callback(ch, method, properties, body):
        try:
            message = json.loads(body)
            job_id = message["id"]
            a = float(message["a"])
            b = float(message["b"])
            op = message["op"]

            if op == '+':
                result = a + b
            elif op == '-':
                result = a - b
            elif op == '*':
                result = a * b
            elif op == '/':
                result = a / b
            else:
                result = None

            redis_db.set(job_id, result)
            print(f"[x] Job {job_id} done → {result}", flush=True)

        except Exception as e:
            print(f"[!] Error: {e}", flush=True)

    channel.basic_consume(queue='calc_queue', on_message_callback=callback, auto_ack=True)

    print("[*] Consumer ready. Waiting for jobs...", flush=True)
    channel.start_consuming()

if __name__ == '__main__':
    main()
