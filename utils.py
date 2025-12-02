import asyncio
import json
from datetime import datetime

def calculate_send_delay(text, reply):
    """计算发送延迟时间"""
    return (len(text) * 0.2 if len(text) >= 30 else 0) + len(reply) * 0.3

async def send_message(ws, delay, payload):
    """发送消息到WebSocket"""
    await asyncio.sleep(delay)
    await ws.send(json.dumps(payload))

async def send_message_list(ws, send_list):
    """发送消息列表"""
    for send_item in send_list:
        await send_message(ws, send_item['delay'], send_item['payload'])