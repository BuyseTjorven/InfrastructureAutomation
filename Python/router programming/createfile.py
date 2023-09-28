import csv

# Define the CSV file path
csv_file = r'Python\router programming\routerprogramming.csv'  # Replace 'your_file.csv' with the actual file path

# Create an empty dictionary to store the data
data_dict = {}

# Open the CSV file and read its contents
with open(csv_file, mode='r') as file:
    csv_reader = csv.DictReader(file, delimiter=';')

    # Iterate over the CSV file
    for row in csv_reader:
        # Add the data to the dictionary, with default values for empty fields
        data_dict[row['network']] = {
            'interface': row['interface'] or '',
            'description': row['description'] or '',
            'vlan': row['vlan'] or '',
            'ipaddress': row['ipaddress'] or '',
            'netmask': row['netmask'] or '',
            'defaultgateway': row['defaultgateway'] or '',
        }

# Create a text file to store the configuration
with open('configuration.txt', 'w') as file:
    # Iterate over the dictionary
    for network in data_dict:
        # Create a configuration block for each network
        file.write('interface {}'.format(data_dict[network]['interface']))
        file.write('\n description {}'.format(data_dict[network]['description']))
        file.write('\n ip address {} {}'.format(data_dict[network]['ipaddress'], data_dict[network]['netmask']))
        if data_dict[network]['defaultgateway'] != '':
            file.write('\n ip default-gateway {}'.format(data_dict[network]['defaultgateway']))
        file.write('\n\n')

# Print a message to the console
print('The configuration has been written to configuration.txt')