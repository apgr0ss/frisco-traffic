import csv
import os

uncat = "UNCATEGORIZED"

street_dict = {}
nti = {}

with open("streets.csv", "r") as f:
	r = csv.reader(f, delimiter=',', quotechar='\"')
	#headers = r[0]
	join_column = 6
	arr = []
	for row in r:
		arr.append(row)
i = 1
while i < len(arr):
	if arr[i][join_column] not in street_dict:
		street_dict[arr[i][join_column]] = []
	street_dict[arr[i][join_column]].append(arr[i])
	i = i + 1
street_dict[uncat] = []

for street, data in street_dict.iteritems():
	#print street
	#print data
	nti[street] = []
	try:
		os.mkdir("streets/" + str(street).replace('/','-') + ".dir")
	except:
		print("streets/" + str(street).replace('/','-') + ".dir already exists")

	with open("streets/" + str(street).replace('/','-'), "w") as f:
		for item in data:
			j = 0
			while j < len(item):
				f.write(item[j])
				j = j + 1
				if len(item) != j:
					f.write(',')
			f.write('\n')
nti[uncat] = []
#minor reports
with open("nti.csv", "r") as n:
	r = csv.reader(n, delimiter=',', quotechar='\"')
	#headers = r[1]
	search_column = 4
	nti_arr = []
	for row in r:
		nti_arr.append(row)
i = 2
while i < len(nti_arr):
	found_a_match = False
	for street, data in street_dict.iteritems():
		#print (nti_arr[i][search_column].upper())
		if str(street) in nti_arr[i][search_column].upper():
			nti[street].append(nti_arr[i])
			found_a_match = True
			# DO NOT stop because it may be an intersection
	if found_a_match is not True:
		nti[uncat].append(nti_arr[i])
	i = i + 1

#print("dict size: " + str(len(nti)))

for street, data in nti.iteritems():
	#print street
	#print data
	with open("streets/" + str(street).replace('/','-') + ".dir/nti.csv", "w") as f:
		for item in data:
			j = 1
			while j < len(item):
				f.write(item[j])
				j = j + 1
				if len(item) != j:
					f.write(',')
			f.write('\n')

	
	
