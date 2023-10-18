##################################################################################
#                                                                                #
#                                                                                #
#         Python script to list all current AWS policies & write to a CSV        #
#         with columns ['Policy Name', 'PolicyId', and 'Arn']                    #
#                                                                                #
#                                                                                #
##################################################################################


import boto3
from datetime import datetime
import csv



def get_boto_client():                                                #Create and return a IAM bot3 client
    try:
        client = boto3.client('iam')
        return client
    except Exception as e:
        print(f"Cant create a boto3 client: {e}")
        return None


boto_iam_client = get_boto_client()                                  #Set boto3 IAM client to a variable

                                                                   
def return_iam_policies(client):                                     #Make a function that returns a list of IAM policies 
    try:
        response = client.list_policies()
        return response['Policies']
    except Exception as e:
        print(f"Couldnt retrun a list of IAM policies{e}")
        return []

                                                                     
list_of_policies = fetch_iam_policies(boto_client)                    #Set list of returned policies to a variable


                                                                      
def get_csv_filename():                                               #Create a file name that includes the current date & time with a function
    current_datetime = datetime.now().strftime('%Y%m%d_%H%M%S')
    name_of_csv_file = f"current_iam_policies_{current_datetime}.csv"
    return name_of_csv_file


                                                                        
def write_policies_to_csv(policy_list):                                 #A function that writes our list of policies to a CSV file
    try:
        file_name = get_csv_filename()                                  #Set return of get_csv_filename function to a variable

        with open(file_name, 'w', newline='') as csvfile:               # open a new file to write into
            column_names = ['PolicyName', 'PolicyId', 'Arn']            # store column names in a list
            writer = csv.DictWriter(csvfile, fieldnames=column_names)   # Send newly opend file and column names to Dictwriter. Store as our writer object
            
            writer.writeheader()                                        # Write the header with what we current have in writer
            
            for policy in policy_list:                                  # loop through the polocy list
                writer.writerow({                                       # use the writer object to write a row into the csv file using the writerow method...
                    'PolicyName': policy['PolicyName'],                 # the row will be an object thats made of 'PolicyName', 'PolicyId', 'Arn'
                    'PolicyId': policy['PolicyId'],
                    'Arn': policy['Arn']
                })
    except Exception as e:                                              # Handle any errors
        print(f"Error writing policies to CSV: {e}")

                                                                        # Make a main function that runs if returning a boto3 client was successful and returning a list of policies was successful
def current_iam_policies_to_csv():
    if boto_client and list_of_policies:
        write_policies_to_csv(list_of_policies) 
    else:
        print("Couldnt write policies to CSV: Check error messages.")


current_iam_policies_to_csv()                                            # Run the main function
