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

import csv

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
    print(f"VLAN: {vlan}, Name: {details['name']}, Subnet: {details['subnet']}, Netmask: {details['netmask']}, Ports: {details['ports']}")

