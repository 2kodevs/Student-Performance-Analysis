with open("students-data.csv", "r") as fd:
    raw_data = fd.read()
    data = raw_data.split("\n")
    raw_data = data[0].split(',')
    amount = len(raw_data)
    for i in data:
        t = i.split(",")
        print((len(t), len(t) == amount))