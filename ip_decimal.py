import socket

ip = socket.gethostbyname(socket.gethostname())
octets = ip.split(".")
number = 0

for octet in octets:
    number = (number << 8) + int(octet)

print(number)
