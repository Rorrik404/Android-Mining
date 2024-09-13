import socket

def query_ccminer(cmd="hwinfo", address="", port=4068):
    try:
        # Create a TCP/IP socket
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            # Connect to the server at the specified address and port
            sock.connect((address, port))
            
            # Send the command to the server
            cmd_with_newline = (cmd + "\n").encode('ascii')
            sock.sendall(cmd_with_newline)
            
            # Receive the response from the server
            response = sock.recv(4096).decode('ascii')
            
            sock.close()
            # Print the response
            print(response)
    except Exception as e:
        print("No Connection:", e)


address_list = ["192.168.1.154", "192.168.1.155", "192.168.1.156", "192.168.1.157", "192.168.1.151", "192.168.1.148", "192.168.1.149", 
                "192.168.1.137", "192.168.1.138", "192.168.1.139"]

# Example usage
for ip in address_list:
    query_ccminer(address=ip)