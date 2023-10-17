# Run pip install psutil as root user & run file with sudo or else you'll get permission denied 

from datetime import datetime
import psutil
import csv

# Store the list of process_ids in a variable
processes = psutil.pids()

def current_running_processes():

    # Store the name of the file in a variable
    current_datetime = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    filename = f"current_running_process_{current_datetime}.csv"

    with open (filename, 'w', newline='') as file:
        # Pass our running_processes.csv file to our csv writer object
        writer = csv.writer(file)

        # Store the column headers in a variable
        field = [ "process_id", "process_name", "process_path", "process_cpu", "process_memory"]
        
        # Write the column names horizontally as headers
        writer.writerow(field)

        #Loop over the list of process ids
        for process in processes:

            #Store the collection of data for each process in a variable
            process_id_data = psutil.Process(process)

            #Store the id, name, path, cpu, memory of each process id in seperate variables
            process_id= process
            process_name= process_id_data.name()
            process_path= process_id_data.exe()
            process_cpu= process_id_data.cpu_percent()
            process_mem= process_id_data.memory_percent()

            #Put each process data point in a list and pass it to the writerow method to be wriote into the csv file
            writer.writerow([process_id, process_name, process_path, process_cpu, process_mem])

current_running_processes ()
