import csv

# Assuming your CSV file is named 'output.csv'
file_path = 'output.csv'

# Open the CSV file
with open(file_path, 'r') as csvfile:
    # Create a CSV reader object
    csvreader = csv.reader(csvfile)
    
    with open('ipv4.txt', 'w') as output_file:

        # Iterate through each row in the CSV file
        for row in csvreader:
            # Assuming that the relevant line is in the first column
            line = row[0]
            
            # Your code to extract src_ip from 'line' goes here
            # (using the previous code example)

            # Split the line by commas
            values = line.split(", ")

            # Find the element that starts with 'src_ip'
            src_ip_element = next(element for element in values if element.startswith("src_ip="))

            # Extract the src_ip value
            src_ip = src_ip_element.split("=")[1]

            # For example:
            # src_ip_element = next(element for element in values if element.startswith("src_ip="))
            # src_ip = src_ip_element.split("=")[1]
            
            print(src_ip)
            
            output_file.write(src_ip + '\n')
