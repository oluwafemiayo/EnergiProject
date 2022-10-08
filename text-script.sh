#Here we will create a colum list of presidents, age and their country.

touch presidents.txt
vi presidents.txt
cat presidents.txt


FirstName       lastName       age     Country       


Muhammad         Buhari        79      Nigeria   
Emmanuel         Macron        44      France    
Recirp           Erdogan       68      Turkey
Joe              Biden         79      USA
Vladmir          Putin         70      Russia 


#Problems
1: How can we print out just a particular pattern, lets say the name that starts with E
2: How can we print out just the country which is the last colum
3: How can we output just one president at a time

Solution
---
# 1: We will output an info of president with the letter E name start.
#command:
  awk '/^E/'  presidents.txt
#output: 
  Emmanuel         Macron        44      France
---
2: we will solve the last colum 
#command:
  awk '{print $NF}'  presidents.txt
#output: 
Country


Nigeria
France
Turkey
USA
Russia

---
3: we will output one president at a time and not all
solution:
#command
grep Buhari presidents.txt
#output:
Muhammad         Buhari        79      Nigeria

