def Average(lst): 
    avg = sum(lst) / len(lst)
    return round(avg, 2)


f = open("./CSV Cleaned/Soil Temperatures for Fargo and Grand Forks_cleaned.csv", "r")
lines = []
for line in f:
    lines.append(line)

soil5, soil10, soil20, soil30, soil40, soil50, soil60, soil80, soil100, soil125, soil150, soil200, soil225 = [], [], [], [], [], [], [], [], [], [], [], [], []
complete_data = []
dayArray = []

for i in range(0, len(lines)-1):
    
    location = lines[i].split(',')[0]
    date = lines[i].split(',')[1].split(' ')[0]
    day = date.split('-')[0]
    #print(lines[i+1].split(',')[1].split(' ')[0].split('-')[2])
    if (day != lines[i+1].split(',')[1].split(' ')[0].split('-')[2]):
        # add values to arrays
        soil5.append(lines[i].split(',')[2])
        soil10.append(lines[i].split(',')[3])
        soil20.append(lines[i].split(',')[4])
        soil30.append(lines[i].split(',')[5])
        soil40.append(lines[i].split(',')[6])
        soil50.append(lines[i].split(',')[7])
        soil60.append(lines[i].split(',')[8])
        soil80.append(lines[i].split(',')[9])
        soil100.append(lines[i].split(',')[10])
        soil125.append(lines[i].split(',')[11])
        soil150.append(lines[i].split(',')[12])
        soil200.append(lines[i].split(',')[13])
        soil225.append(lines[i].split(',')[14])
    else:
        soil5.append(lines[i].split(',')[2])
        soil10.append(lines[i].split(',')[3])
        soil20.append(lines[i].split(',')[4])
        soil30.append(lines[i].split(',')[5])
        soil40.append(lines[i].split(',')[6])
        soil50.append(lines[i].split(',')[7])
        soil60.append(lines[i].split(',')[8])
        soil80.append(lines[i].split(',')[9])
        soil100.append(lines[i].split(',')[10])
        soil125.append(lines[i].split(',')[11])
        soil150.append(lines[i].split(',')[12])
        soil200.append(lines[i].split(',')[13])
        soil225.append(lines[i].split(',')[14])


        dayArray.append(location)
        dayArray.append(date)
        # calculate mean
        dayArray.append(Average(soil5))
        dayArray.append(Average(soil10))
        dayArray.append(Average(soil20))
        dayArray.append(Average(soil30))
        dayArray.append(Average(soil40))
        dayArray.append(Average(soil50))
        dayArray.append(Average(soil60))
        dayArray.append(Average(soil80))
        dayArray.append(Average(soil100))
        dayArray.append(Average(soil125))
        dayArray.append(Average(soil150))
        dayArray.append(Average(soil200))
        dayArray.append(Average(soil225))
        complete_data.append(dayArray)
        soil5, soil10, soil20, soil30, soil40, soil50, soil60, soil80, soil100, soil125, soil150, soil200, soil225 = [], [], [], [], [], [], [], [], [], [], [], [], []
        dayArray = []

print(complete_data)

f.close()
