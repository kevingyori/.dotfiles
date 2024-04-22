
import json
import subprocess

# Load the JSON data from the file
# with open('test.json', 'r') as file:
#     data = json.load(file)

data = json.loads(
    subprocess.run(
        ["kitty", "@", "ls"], capture_output=True, text=True
    ).stdout.strip("\n")
)

# Create a dictionary to store tabs and their corresponding windows
tabs_dict = {}

# Iterate over each tab
for tab in data[0]['tabs']:
    tab_title = tab['title']
    tabs_dict[tab_title] = []

    # Iterate over each window in the tab
    for window in tab['windows']:
        window_title = window['title']
        window_id = window['id']
        tabs_dict[tab_title].append(
            {"window_title": window_title, "window_id": window_id})

# Print the dictionary
print(json.dumps(tabs_dict, indent=4, sort_keys=True))

print("------------------\n")


# Create a dictionary to store windows from the active tab
active_tab_windows = {}

# Iterate over each tab
for tab in data[0]['tabs']:
    if tab['is_active']:
        tab_title = tab['title']
        active_tab_windows[tab_title] = []

        # Iterate over each window in the active tab
        for window in tab['windows']:
            window_title = window['title']
            window_id = window['id']
            window_active = window['is_active']
            working_directory = window['env']['PWD'].split('/')[-1]
            active_tab_windows[tab_title].append(
                {"window_title": window_title,
                    "window_id": window_id,
                    "is_active": window_active,
                    "working_directory": working_directory
                 })

# Print the dictionary containing windows from the active tab
print(json.dumps(active_tab_windows, indent=4, sort_keys=True))


# get window_title from active_tab_windows
active_window_titles = []

for tab_title, windows in active_tab_windows.items():
    for window in windows:
        active_window_titles.append(window["window_title"])

print(active_window_titles)
print("\n")
