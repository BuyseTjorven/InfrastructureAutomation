#bij start username en password vragen voor switch
#getpass gebruiken want passowrd

#net_connect gebruikten

#parser gebruiken?? voor errors die beter zijn parser.addargument enzo

#show cdp neiighbors detail | inclide device ID| IP address| Interface

#output =net_connect.send_config_set(commands)

#om poorten te configureren
#prts = "1-8,9-16,22"
#ports = ports.split(',')
#for ports in ports:
# print(port)
#if '-' in port:
#    print(f"int range gi0/{port}")
#else:
#    print(f"int gi0/{port}")

#read switchprogramming.csv file


#voor resetten :)
#del vlan.dat (delete vlan database)
#erase startup-config (delete startup config)
#reload (reload switch)

import csv
from netmiko import ConnectHandler



def portcalculate (ports):
    ports = ports.split(',')
    for port in ports:
        if '-' in port:
            print(f"int range fa0/{port}")
            return f"int range fa0/{port}"
        else:
            print(f"int fa0/{port}")
            return f"int fa0/{port}"

# Define the CSV file path
csv_file = 'Python\switch programming\switchprogramming.csv'  # Replace 'your_file.csv' with the actual file path

# Create an empty dictionary to store the data
data_dict = {}

# Open the CSV file and read its contents
with open(csv_file, mode='r') as file:
    csv_reader = csv.DictReader(file, delimiter=';')
    
    # Iterate over each row in the CSV and store it in the dictionary
    for row in csv_reader:
        vlan = row['vlan']
        data_dict[vlan] = {
            'name': row['name'],
            'subnet': row['subnet'],
            'netmask': row['netmask'],
            'ports': row['ports']
        }

# Print the data as a dictionary
for vlan, details in data_dict.items():
    #print(f"VLAN: {vlan}, Name: {details['name']}, Subnet: {details['subnet']}, Netmask: {details['netmask']}, Ports: {details['ports']}")
    print("command 1")
    command = []
    command.append(f"vlan {vlan}")
    command.append(f"name {details['name']}")
    command.append(f"interface {vlan}")
    command.append(f"description {details['name']}")
    #command.append(f"ip address {details['subnet']} {details['netmask']}")
    #hierboven voor layer 3
    command.append("no ip address")
    command.append("no shut")
    print(command)
    print()
    print("command 2")
    command = []
    command.append(f"{portcalculate(details['ports'])}")
    command.append("switchport mode access")
    command.append("spanning-tree portfast")
    command.append(f"switchport access vlan {vlan}")
    print(command)
    print()
cisco_881 = {
    'device_type': 'cisco_ios',
    'host':   '192.168.1.5',
    'username': 'tjorven',
    'password': 'tjorven',
    'secret': 'tjorven',
    'session_log': 'session.log',  # Optional, for debugging
    'fast_cli': False,  # Optional, might help with some devices
    'timeout': 120,  # Increase the timeout if necessary
    'global_delay_factor': 2,  # Optional, adjust as needed
    #'device_prompt': 'Switch>',  # Specify your device's prompt
}

print('command final')
print(command)
net_connect = ConnectHandler(**cisco_881)
net_connect.enable()
#commands = ["vlan 10", "name VLAN10", "interface vlan 10", "description VLAN10", "no ip address", "no shut", "interface range fa0/2-8", "switchport mode access", "spanning-tree portfast", "switchport access vlan 10"]

# Send configuration commands
output = net_connect.send_config_set(command)
output += net_connect.save_config()

# Close the connection
net_connect.disconnect()

print()
print(output)
print()







