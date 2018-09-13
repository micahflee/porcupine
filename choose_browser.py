import subprocess
from os import listdir
from os.path import isfile, join, isdir

# Path to applications in Linux
all_applications_path = ['/usr/share/applications/', '/usr/local/share/applications/', '~/.local/share/applications/']

applications_path = '/usr/share/applications/' # TODO: add /usr/local/share/applications, and ~/.local/share/applications later


# Loop over paths
#for path in all_applications_path:

# create file exists exception
    # Collect all applications in path
all_applications_list = [f for f in listdir(applications_path) if isfile(join(applications_path, f))]
    
 #   else:
 #       continue

available_browsers_name = []

# Create list of http/https applications
for file in all_applications_list:
    if ".desktop" in file:
        filepath = applications_path + file
        searchfile = open(filepath, "r")
        for line in searchfile:
            if "x-scheme-handler/http" in line:
                available_browsers_name.append(file)
        searchfile.close()

# Dictionary to store:
#   keys = .desktop
#   values = paths in list[icon,executable]
browser_info = {}

# Search through browser list and store in browser_info dictionary
for browser in available_browsers_name:
    available_browsers = applications_path + browser
    searchbrowser = open(available_browsers, "r")
    item_list = []
    for line in searchbrowser:
        if "Icon=" in line:            
            item_list.append(line.strip())#line[5:].strip())
        if "Exec=" in line:
            item_list.append(line.strip())#[5:].strip())
        browser_info[browser] = item_list
    searchbrowser.close()

browser_list = []

# Return Dictionary
for key, value in sorted(browser_info.items()):
    browser_list.append(key[:-8]) # remove .desktop from names

for key in browser_list:
    key = key + ".desktop"
    print("Browser:\t" + key[:-8])
    print("Exec path:\t" + browser_info.get(key)[0][5:]) #note, this is just 1st, not necessarily exec
    print("Icon path:\t" + browser_info.get(key)[1][5:]) #note, this is just 1st, not necessarily icon
    print("\n")

