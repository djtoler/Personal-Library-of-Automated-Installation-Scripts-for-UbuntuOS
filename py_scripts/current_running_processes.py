# Run pip install psutil and change file permission to execute file if needed 

#import the following python modules
from datetime import datetime
import psutil
import csv

#Set variable to date and time to be used later in the file name
current_datetime = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
filename = f"current_running_process_{current_datetime}.csv"

#Set the list of process_ids to a variable
processes = psutil.pids()

#Define a fuction:
def current_running_processes():
    #Incorporate error handling
    try:
      #Open a CSV file to write into
        with open (filename, 'w', newline='') as file:
                #Create a writer object variable to write into the csv
                writer = csv.writer(file)

                #Set the column headers to a variable
                field = [ "process_id", "process_name", "process_path", "process_cpu", "process_memory"]
                
                # Write into the csv row the column headers
                writer.writerow(field)

                #Loop through each process
                for process in processes:

                    #Set a variable to that allows the access of information within the psutil library and Process class
                    process_id_data = psutil.Process(process)

                    #Set id, name, path, cpu, memory to a variables
                    process_id = process
                    process_name = process_id_data.name()
                    process_path = process_id_data.exe()
                    process_cpu = process_id_data.cpu_percent()
                    process_mem = process_id_data.memory_percent()

                    #Write into the csv row the following
                    writer.writerow([process_id, process_name, process_path, process_cpu, process_mem])
    #For the following exceptions:
    except(psutil.NoSuchProcess, psutil.AccessDenied):
        #return none of each field
         return None, None, None, None, None
         
current_running_processes ()



    

