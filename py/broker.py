import asyncio
import hbmqtt.broker as mqtt_broker
import logging
from host_address import host_ip, port


logger = logging.getLogger(__name__)
config = {
    'listeners': {
        'default': {
            'type': 'tcp',
            # your ip and port
            'bind': f'{host_ip}:{port}'    # 0.0.0.0:1883
        }
    },
    'sys_interval': 10,
    "topic-check":{
        "enabled": False,
        "acl":{
            "anonymous" : ["topic/#"],
            "user_name": ["topic/#"]
        }
    }
}

async def start_broker():
    broker = mqtt_broker.Broker(config)
    await broker.start()

if __name__ == '__main__':
    formatter = "[%(asctime)s] :: %(levelname)s :: %(name)s :: %(message)s"
    logging.basicConfig(level=logging.INFO, format=formatter)
    asyncio.get_event_loop().run_until_complete(start_broker())
    asyncio.get_event_loop().run_forever()

