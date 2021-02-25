#!/usr/bin/python
import pymysql
import pymysql.cursors
import subprocess as sp
import json
from datetime import date
from random import randint
# Open database connection
# a = 5005
# prepare a cursor object using cursor() method
# abstraction meant for data set traversal
def execute_query(query, x):
 try:
     # Execute the SQL command
     cursor.execute(query)
     # Commit your changes in the database
     db.commit()
     row = cursor.fetchall()
     if x == 1:
         for r in row:
             print(r)
     rc = cursor.rowcount
     if x == 1:
         print("\nRow count: ", rc)
     return row
 except Exception as e:
     # Rollback in case there is any error
     db.rollback()
     print(">>>>>>>>>>>>>", e)
     return "-1"
def make(a):
 a = str(a)
 a = a.replace('(', '')
 a = a.replace(')', '')
 a = a.replace(',', '')
 a = a.replace("'", '')
 return a
def Bill(PID):
 x2 = execute_query(
     "select Cost from Rooms where Room_No=(select Room_No from Patient where Patient_ID = " + str(PID) + ");", 0)
 if x2[0][0] != None:
     x2 = int(x2[0][0])
 else:
     x2 = 0
 print("Room Bill = " + str(x2) + "\n")
 TID = execute_query(
     "select Treatment_ID from Treatment where Patient_ID = " + str(PID) + ";", 0)
 if TID[0][0] != None:
     TID = int(TID[0][0])
 else:
     TID = 0
 x3 = execute_query(
     "select Bill from Treatment where Patient_ID = " + str(PID) + ";", 0)
 if x3[0][0] != None:
     x3 = int(x3[0][0])
 else:
     x3 = 0
 x1 = execute_query(
     "select sum(Cost) from Medicine where Medicine_ID in (select Medicine_ID from Prescription where Patient_ID = " + str(PID) + ");", 0)
 # print("select Cost from Rooms where Room_No=(select Room_No from Patient where Patient_ID = " + str(PID) + ");")
 if x1[0][0] != None:
     x1 = int(x1[0][0])
 else:
     x1 = 0
 print("Doctor Bill = 1000\n")
 print("Medicine Bill = " + str(x1) + "\n")
 print("Treatment Bill = " + str(x3) + "\n")
 print("Total Bill = " + str(x1+x2+1000 + x3) + "\n")
def Admit_Patient(ID, RID, Fname, Mname, Lname, Address, email, sex, DOB, Disease_ID, phnos):
 mxi = execute_query("select count(Doctor_ID) from Doctor;", 0)
 if mxi[0][0] > 0:
     mxi = int(mxi[0][0])
 else:
     mxi = 1
 DID = randint(1, mxi)
 TID = execute_query("select max(Treatment_ID) from Treatment;", 0)
 if TID[0][0] > 0:
     TID = int(TID[0][0]) + 1
 else:
     TID = 1
 x1 = execute_query(
     "select Patient_ID from Patient where Patient_ID=" + str(ID) + ";", 0)
 if x1 != ():
     print("Patient_ID already present")
     return 0
 y =execute_query("INSERT INTO Patient values ( '" + str(ID) + "' , '" + str(RID) + "','" + str(DID) + "','" + Fname + "','" + Mname + "','" +
               Lname + "','" + str(Address) + "','" + str(email) + "','" + str(sex) + "','" + str(DOB) + "' , 'Alive');", 1)
 if y == -1:
         print("Not inserted")
 for i in phnos:
     y =execute_query("insert into Patient_numbers values ('" +
                   str(ID) + "','" + i + "' );", 1)
     if y == -1:
         print("Not inserted") 
 y = execute_query("INSERT INTO Illness values ( '" +
               str(Disease_ID) + "','" + str(ID) + "');", 1)
 if y == -1:
         print("Not inserted")
 y = execute_query("INSERT INTO Treatment values ('" + str(TID) + "','" + str(ID) +
               "','" + str(randint(1000, 1500)) + "','" + str(randint(2, 10)) + "');", 1)
 if y == -1:
         print("Not inserted")
 New_Bill(DID, 0, RID, TID)
 return 0
def Hire_Nurse(ID, RID, Fname, Mname, Lname, sex, Qual, Phno):
 y = execute_query("insert into Nurse values ( '" + str(ID) + "','" + str(RID) + "','" +
               Fname + "','" + Mname + "','" + Lname + "','" + sex + "','" + Qual + "' );", 1)
 if y == -1:
         print("Not inserted")
 for i in Phno:
     y=execute_query("insert into Nurse_Number values ('" +
                   str(ID) + "','" + i + "' );", 1)
     if y == -1:
         print("Not inserted") 
def Hire_Doctor(ID, sex, Email, Class, Fname, Mname, Lname, address, DOB, Qual):
 y = execute_query("insert into Doctor values('" + str(ID) + "','" + sex + "','" + Email + "','" +
               Class + "','" + Fname + "','" + Mname + "','" + Lname + "','" + address + "','" + DOB + "');", 1)
 if y == -1:
         print("Not inserted")
 for i in Qual:
     y = execute_query(
         "insert into Doctor_Qualification values ('" + str(ID) + "','" + i + "' );", 1)
     if y == -1:
         print("Not inserted") 
def New_Bill(DId, MId, RId, TId):
 # print("insert into Bill values ('" + str(DId) + "','" + str(MId) + "','" + str(RId) + "','" + str(TId) + "');")
 y = execute_query("insert into Bill values ('" + str(DId) + "','" +
               str(MId) + "','" + str(RId) + "','" + str(TId) + "');", 1)
 if y == -1:
         print("Not inserted") 
def insert_into_table():
 cnt = 1
 a = execute_query("SHOW TABLES;", 0)
 print("\nSelect Table Number\n")
 for i in ["Disease", "Medicine", "Patient_Attender", "Rooms", "Patient", "Nurse", "Doctor"]:
     print(str(cnt) + ") " + make(i))
     cnt += 1
 cnt = 1
 print()
 x = input("Enter Choice : ")
 if x == '':
     print("Invalid Input")
     print()
     return 0
 x = int(x)
 if x == 1:
     x = 2
 elif x == 2:
     x = 6
 elif x == 3:
     x = 10
 elif x == 4:
     x = 13
 elif x == 5:
     print("Enter the following seperated by a space :")
     print("ID , Room_No ,  Fname , Mname , Lname , Address , E-Mail ID ,  sex  , DOB , Disease_ID , Phone numbers")
     inp = input().split()
     if len(inp) != 11:
         print("Invalid Input\n")
         return 0
     arr = []
     for i in range(10, len(inp)):
         arr.append(inp[i])
     Admit_Patient(int(inp[0]), int(inp[1]), inp[2], inp[3],
                   inp[4], inp[5], inp[6], inp[7], inp[8], int(inp[9]), arr)
     return 0
 elif x == 6:
     print("Enter the following seperated by a space :")
     print("ID , RID , Fname , Mname , Lname , sex , Qualifications, Phone numbers")
   
     inp = input().split()
     length  = len(inp)
     arr = []
     if length < 8:
         print("Invalid Input\n")
         return 0
     for i in range(7, length):
         arr.append(inp[i])
     Hire_Nurse(int(inp[0]), int(inp[1]), inp[2],
                inp[3], inp[4], inp[5], inp[6], arr)
     return 0
 elif x == 7:
     lentgh = 0
     print("Enter the following seperated by a space :")
     print("ID , sex , E-mail ID , Class ,Fname , Mname , Lname , Address, D.O.B, Qualifications ")
     inp = input().split()
     length = len(inp)
     arr = []
     if length < 10:
         print("Invalid Input\n")
         return 0
  
     for i in range(9, length):
         arr.append(inp[i])
     Hire_Doctor(int(inp[0]), inp[1], inp[2], inp[3],
                 inp[4], inp[5], inp[6], inp[7], inp[8], arr)
     return 0
 else:
     print("Invalid Input")
     print()
 a1 = execute_query("DESCRIBE " + make(a[x-1]) + ";", 0)
 print("Enter the values of ", end="")
 for i in a1:
     print(i[0], end=" ")
 print("seperated by a space")
 inp = input().split(" ")
 if len(inp) != len(a1):
     print("Invalid Input\n")
     return 0
 st = "("
 for i in inp:
     st += "'"
     st += str(i)
     st += "'"
     if cnt != len(inp):
         st += ","
     else:
         st += ")"
     cnt += 1
 execute_query("INSERT INTO " + make(a[x-1]) + " values " + st + ";", 1)
def show():
 cnt = 1
 a = execute_query("SHOW TABLES;", 0)
 print("Select Table Number")
 print()
 for i in a:
     print(str(cnt) + ") " + make(i))
     cnt += 1
 print()
 y = input("Enter Choice : ")
 if y == '':
     print("Invalid Input")
     return 0
 x = int(y)
 a1 = execute_query("DESCRIBE " + make(a[x-1]) + ";", 0)
 for i in a1:
     print(i[0], end=" ")
 print()
 execute_query("SELECT * FROM " + make(a[x-1]) + ";", 1)
def Delete_Medicine(Medicine_ID):
 y = execute_query("delete from Medicine where Medicine_ID = " +
               str(Medicine_ID) + ";", 1)
 if y == -1:
         print("Not inserted")
 y = execute_query("delete from Prescription where Medicine_ID = " +
               str(Medicine_ID) + ";", 1)
 if y == -1:
         print("Not inserted") 
def Discharge_Patient(Patient_ID):
 x = execute_query("delete from Patient_numbers where Patient_ID = " + str(Patient_ID) + ";", 1)
 if x == -1:
     print("Not Discharged")
 x = execute_query("delete from Prescription where Patient_ID = " +
               str(Patient_ID) + ";", 1)
 if x == -1:
     print("Not Discharged")
 x = execute_query(
     "delete from Patient_Attender where Patient_ID = " + str(Patient_ID) + ";", 1)
 if x == -1:
     print("Not Discharged")
 x = execute_query("delete from Illness where Patient_ID = " +
               str(Patient_ID) + ";", 1)
 if x == -1:
     print("Not Discharged")
 x = execute_query(
     "delete from Bill where Treatment_ID = (select Treatment_ID from Treatment where Patient_ID = " + str(Patient_ID) + ");", 1)
 if x == -1:
     print("Not Discharged")
 x = execute_query("delete from Treatment where Patient_ID = " +
               str(Patient_ID) + ";", 1)
 x = execute_query("delete from Patient where Patient_ID = " +
               str(Patient_ID) + ";", 1)
 if x == -1:
     print("Not Discharged")
def Fire_Doctor(Doctor_ID):
 x = execute_query(
     "select Patient_ID from Patient where Doctor_ID = " + str(Doctor_ID) + ";", 0)
 if x != ():
     print("Patient present for doctor, cannot fire doctor")
 else:
     y = execute_query(
         "delete from Doctor_Qualification where Doctor_ID =" + str(Doctor_ID) + ";", 1)
     if y == -1:
         print("Not Fired")
     y = execute_query("delete from Doctor where Doctor_ID = " +
                   str(Doctor_ID) + ";", 1)
     if y == -1:
         print("Not Fired")
    
   
def Fire_Nurse(Nurse_ID):
 y=execute_query("delete from Nurse where Nurse_ID = " +
               str(Nurse_ID) + ";", 1)
 if y == -1:
         print("Not Fired")
 y=execute_query("delete from Nurse_Number where Nurse_ID = " +
               str(Nu_ID) + ";", 1)
 if y == -1:
         print("Not Fired")             
def delete_all():
 a = execute_query("SHOW TABLES;", 0)
 for i in a:
     y=execute_query("delete from " + make(i) + ";", 1)
     if y == -1:
         print("Not deleted")
def delete():
 cnt = 0
 print("Select Option")
 for i in ["Delete Medicine", "Discharge Patient", "Fire Doctor", "Fire Nurse", "Delete All Rows From All Tables"]:
     cnt += 1
     print(str(cnt) + ") " + make(i))
 cnt = 1
 print()
 y = input("Enter Choice : ")
 if y == '':
     print("Invalid Input")
     print()
     return 0
 x = int(y)
 if x == 5:
     delete_all()
   
 elif x == 4:
     print()
     Fire_Nurse(int(input("Enter the Nurse ID : ")))
 elif x == 3:
     print()
     Fire_Doctor(int(input("Enter the Doctor ID : ")))
 elif x == 2:
     print()
     Discharge_Patient(int(input("Enter the Patient ID : ")))
 elif x == 1:
     print()
     Delete_Medicine(int(input("Enter the Medicine ID: ")))
 else:
     print("Invalid Input")
     return 0
 return 0
def Update_PatientCondition(PId, Cond):
 y =execute_query("update Patient SET Condn = '" + Cond +
               "' WHERE Patient_ID = " + str(PId) + ";", 1)
 if y == -1:
         print("Not deleted") 
def Update_PatientMedicine(PId, From_Medicine, To_Medicine):
 TId = execute_query(
     "select Treatment_ID from Treatment where Patient_ID = " + str(PId) + ";", 0)
 if TId[0][0] != None:
     TId = int(TId[0][0])
 else:
     TId = 0
 if To_Medicine == 0 and From_Medicine != 0:
     y=execute_query("delete from Bill WHERE Treatment_ID = " +
                   str(TId) + " AND Medicine_ID = " + str(From_Medicine) + ";", 1)
     if y == -1:
         print("Not deleted")
     y=execute_query("delete from Prescription WHERE Patient_ID = " +
                   str(PId) + " AND Medicine_ID = " + str(From_Medicine) + ";", 1)
     if y == -1:
         print("Not deleted") 
 elif To_Medicine != 0 and From_Medicine != 0:   
     y =execute_query("update Prescription SET Medicine_ID = " + str(To_Medicine) +
                   " WHERE Patient_ID = " + str(PId) + " AND Medicine_ID = " + str(From_Medicine) + ";", 1)
     if y == -1:
         print("Not deleted")
     y = execute_query("update Bill SET Medicine_ID = " + str(To_Medicine) +
                   " WHERE Treatment_ID = " + str(PId) + " AND Medicine_ID = " + str(From_Medicine) + ";", 1)
     if y == -1:
         print("Not deleted")
 elif To_Medicine != 0 and From_Medicine == 0:
     execute_query("insert into Prescription values('" +
                   str(To_Medicine) + "','" + str(PId) + "');", 1)
     RId = execute_query(
         "select Room_No from Patient where Patient_ID = " + str(PId) + ";", 0)
     if RId[0][0] != None:
         RId = int(RId[0][0])
     else:
         RId = 0
     DId = execute_query(
         "select Doctor_ID from Patient where Patient_ID = " + str(PId) + ";", 0)
     if DId[0][0] != None:
         DId =  int(DId[0][0])
     else:
         DId = 0
     y = execute_query("insert into Bill values('" + str(DId) + "','" +
                   str(To_Medicine) + "','" + str(RId) + "','" + str(TId) + "');", 1)
     if y == -1:
         print("Not deleted") 
 elif To_Medicine == 0 and From_Medicine == 0:
     print("Error : Both Fields given as 0")
def modify():
 print("\n1) Update Patient Condition\n2) Update Patient Medicine\n")
 x = input("Enter Choice : ")
 if x == '':
     print("Invalid Input")
     print()
     return 0
 inp = int(x)
 if inp == 1:
     print("\nEnter Patient_ID and Condition seperated by a space\n")
     inn = input().split(" ")
     if len(inn) == 2:
         Update_PatientCondition(int(inn[0]), inn[1])
     else :
         print("Invalid Input")
 elif inp == 2:
     print("\nEnter the following seperated by a space :\nPatient_Id , From_Medicine , To_Medicine ( 0 if not present )\n")
     inn = input().split(" ")
     if len(inn) == 3:
         Update_PatientMedicine(int(inn[0]), int(inn[1]), int(inn[2]))        
     else:
         print("Invalid Input")
 else :
     print("Invalid Input")
     return 0
def Create_Discharge_Summary(PId):
 print("\nPatient Details\n")
 y=execute_query("select * from Patient where Patient_ID = " +
               str(PId) + ";", 1)
 if y == -1:
         print("Not deleted")
 print("\nPrescription\n")
 y = execute_query(
     "select * from Prescription where Patient_ID = " + str(PId) + ";", 1)
 if y == -1:
         print("Not deleted")
 print("\nDoctor Name\n")
 y = execute_query("select First_Name,Middle_Name,Last_Name from Doctor where Doctor_ID = (select Doctor_ID from Patient where Patient_ID = " + str(PId) + ");", 1)
 if y == -1:
         print("Not deleted") 
 TID = execute_query(
     "select Treatment_ID from Treatment where Patient_ID = " + str(PId) + ";", 0)
 if TID[0][0] != None:
     TID = int(TID[0][0])
 else:
     TID = 0
def Generate_report():
 print("\n1) Generate Discharge Summary\n2) Generate Bill\n")
 y = input("Enter Choice : ")
 if y == '':
     print("Invalid Input")
     print()
     return 0
 x = int(y)  
 if x == 1:
     print("\nEnter Patient_ID of Patient\n")
     inp = input()
     if inp == '':
         print("Invalid Input")
         return 0
     inp = int(inp)
     print()
     Create_Discharge_Summary(inp)
 elif x == 2:
     print("\nEnter Patient_ID of Patient\n")
     inp = input()
     if inp == '':
         print("Invalid Input")
         return 0
     inp = int(inp)
     print()
     Bill(inp)
     
 else:
     print("Invalid Input")
     return 0
# Main Code here
while(1):
 tmp = sp.call('clear', shell=True)
 # Can be skipped if you want to hard core username and password
 username = input("Username: ")
 password = input("Password: ")
 try:
     db = pymysql.connect(host='localhost',
                          user=username,
                          password=password,
                          port = 5005,
                          db='final')
     tmp = sp.call('clear', shell=True)
     if(db.open):
         print("Connected")
     else:
         print("Failed to connect")
     tmp = input("Enter any key to CONTINUE>")
     cursor = db.cursor()
     while True:
         print("\n1) Insert into Table")
         print("2) Modify Row in Table")
         print("3) Delete from Database")
         print("4) Generate Report")
         print("5) Show rows of a table")
         print("6) Exit\n")
         type = input("Enter Choice : ")
         if type == '':
             print("Invalid Input")
             print()
             continue
         type = int(type)
         if type == 1:
             insert_into_table()
         elif type == 2:
             modify()
         elif type == 3:
             delete()
         elif type == 4:
             Generate_report()
         elif type == 5:
             show()
         elif type == 6:
             break
         else:
             print("Invalid Input")
             print()
     # close the cursor
     cursor.close()
     # close the connection
     db.close()
 except:
     tmp = sp.call('clear', shell=True)
     print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
     tmp = input("Enter any key to CONTINUE>")
 
 


