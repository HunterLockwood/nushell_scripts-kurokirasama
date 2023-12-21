# nushell scripts
My collection of Nushell custom commands/functions. 

## Installation
First, clone the repo somewhere you like:
```bash
git clone https://github.com/kurokirasama/nushell_scripts
```

### Credentials
- The `credentials.json.asc` file is an encrypted file with the necessary credentials and API keys that are loaded into `$env.MY_ENV_VARS.api_keys` in `env_vars.nu`. 
- The credentials and API keys services I use in this project are in `credentials_example.json`
- For encryption, you need the `gpg` tool installed. You can encrypt and decrypt using the commands in `crypt.nu`.

### Edit `env_vars.nu`
Modify `$env.PATH` and `$env.MY_ENV_VARS` in `$env_vars.nu` according to your settings.

### Nushell config
1. Modify `append_to_config.nu` and replace with the path to this repo.
2. Take the content of `append_to_config.nu` and copy it at the end of the config.nu file. Or, you can run:
```nu
open append_to_config.nu | save --append $nu.config-path
```
3. Restart Nushell.

## Files description
### ai_tools
They provide a comprehensive suite of tools for interacting with AI services, facilitating tasks such as transcription, summarization, image generation, and text-to-speech conversion. Users can manage and query PDFs, utilize OpenAI's ChatGPT or Google's Gemini for conversations, generate commit messages, transcribe audio from different sources, and create summaries of transcribed text. Additionally, the functions offer the ability to generate subtitles, interact with DALL-E for image creation, and use text-to-speech services from OpenAI and ElevenLabs. These functions are designed to streamline the integration of AI capabilities into users' workflows, enhancing productivity and automation within the Nushell environment.

### alias_def
These custom functions for Nushell provide a variety of utilities for streamlining tasks on a Unix-like system. These functions allow users to analyze code statistics, manage keybindings, navigate to the nu configuration directory, monitor core temperatures, check battery stats, view listening ports, connect to a Bluetooth headset, gather RAM usage data, interface with YouTube through a command-line client, and perform ADB operations for Android devices. Each function is designed to execute a specific task, such as retrieving system information, manipulating environmental settings, or integrating with external applications and devices, all from within the Nushell environment.


### apis
This set of custom functions for Nushell includes a variety of utilities that enhance productivity through automation. There are functions for URL shortening, leveraging services such as Bitly and Rebrandly, complete with clipboard integration for ease of use. Translation capabilities are provided, allowing text to be translated between languages with options to use the MyMemory or OpenAI API. Geo-location functions offer the ability to get coordinates from addresses and vice versa, as well as calculate estimated travel times and directions using Google Maps API. Financial tools include functions to obtain exchange rates from the Fixer.io API with custom currency support. Additionally, there's integration with Google Translate for text translations and with the Joplin note-taking application for searching and editing notes. Each function is designed to interact with external APIs or services, and they often include error handling, API key management, and user interaction for input and selections.

### autolister
Standalone script that get the list of files in provided directory recursively. It is used within `pre_execution_hook.nu` file. 

### backups
These custom functions collectively offer a set of utilities to backup and restore configurations/settings for various applications including Sublime Text, nchat, GNOME shell extensions, and LibreOffice. They also include a function to update Sublime Text syntax highlighting for Nushell commands and another to backup Nushell history. The backup functions typically compress configuration files into `7z` archives or copy them to a backup directory, while the restore functions extract these archives or copy the files back to their original locations. The syntax update function generates a list of nushell commands, including built-ins, plugins, custom commands, keywords, and aliases, and integrates them into the Sublime Text syntax file, with an option to push changes to a repository if specified. Lastly, the history backup function vacuums the nushell command history into a specified output file.

### config
This script job is to configure the shell environment, modifying settings and adding hooks, menus, keybindings, and other elements to enhance user interaction. It adjusts color schemes for different commands based on environmental variables, set preferences for table display, file size color coding, and history file format. It includes hooks to update the shell prompt with Git status and network connectivity, execute scripts before commands, and adjust the environment upon directory changes. It also defines a custom menu for aliases with specific layout and style settings, and they incorporate new keybindings for actions like opening the alias menu, reloading the config, updating the prompt, inserting new lines, and recalling the last argument. The table trim settings are set for truncating long text with an option to keep words together, and the overall configuration is updated to the environment. Additionally, it includes a playful element that fetches a random joke from an online source.

### crypt
These custom functions offer a suite of tools for encrypting, decrypting, and managing credentials. The `nu-crypt` function performs symmetric encryption or decryption on files using GPG, with additional options for suppressing UI prompts and specifying output files for decryption. The `open-credential` function decrypts and parses a JSON file containing credentials, with a UI-toggle option. Lastly, the `save-credential` function updates or adds new credentials to a JSON file, encrypts it, and then removes the unencrypted file, ensuring sensitive information is securely stored. All functions have built-in error handling for invalid flag combinations or missing arguments.

### debloat
This script is collection of commands designed for managing apps on Xiaomi devices using Android Debug Bridge (ADB) commands. It includes commands to uninstall and disable various pre-installed apps and services from the device. The uninstallation commands target Facebook-related apps, while the disablement commands are categorized into three safety levels: safe, supposedly safe, and uncertain. The safe category addresses Xiaomi and MIUI specific apps and services, the supposedly safe category includes a mix of Xiaomi, Google, and other apps, and the not sure category is commented out, indicating ambivalence about the impact of disabling those apps. These functions would help users to debloat their smartphone by removing or disabling unwanted system apps to improve performance and privacy.

### defs
These custom functions provided for nushell aim to enhance the command line experience by offering a variety of utilities. These functions include searching within files or streams with highlighting, copying the current working directory to the clipboard, converting Excel files to CSV, checking if a drive is mounted, retrieving phone numbers from Google contacts, and launching the mcomix application. Additionally, they facilitate obtaining download information from JDownloader, summarizing source file information for nushell scripts, executing web searches from the terminal, marking Habitica dailies as complete, and setting countdown alarms with audible notifications.

Other functions check the validity of web links, send emails via Gmail with signature files, reset Alpine mail client authentication, run MATLAB in CLI mode, download all files with specific extensions from a webpage using wget, compile LaTeX documents, check the status of Maestral (Dropbox client), generate QR codes, compact data by removing empty strings and nulls, serve a local HTTP server, and even open the balenaEtcher app. Each function is designed to perform a specific task, streamlining various operations that a user might need to perform in a Unix-like environment.

### env_change_hook
These custom functions provided perform a series of operations to manage and update the size information of the current working directory (PWD). Initially, it ensures the existence of a `.pwd_sizes.json` file, creating it from a backup if necessary. It then checks conditions such as the time elapsed since the last update and whether the current directory is part of a Google Drive. Based on these conditions, it calculates the size of the PWD, excluding any Google Drive subdirectories, and updates an environment variable accordingly. If the PWD size information is outdated or missing, it recalculates the size and then updates the `.pwd_sizes.json` file with the new size and the current timestamp. The function is careful to exclude updates for Google Drive directories and ensures that the size information is refreshed only after a specified interval, which is set to 12 hours in this case.

### env_vars
These nushell custom functions serve to configure the shell environment with a variety of settings and behaviors. The `$env.PATH` is extended with additional directories, including various user-specific paths and system binaries. The `PROMPT_COMMAND` constructs a dynamic prompt that changes color based on the last command's exit code and displays different symbols and path sizes depending on whether the current directory is the home directory or elsewhere, as well as Git status information. The `PROMPT_COMMAND_RIGHT` is designed to show weather information and command duration on the right side of the prompt, but only if the terminal is wide enough. The `PROMPT_INDICATOR` changes color based on the success of the previous command. The `BROWSER` variable is set to use "lynx," and `LS_COLORS` is configured to colorize file listings. The shell environment also includes a custom `MY_ENV_VARS` hashmap that holds various user-defined variables and paths, which are set and updated using the `upsert` function. Additionally, `PAGER` is set to "less," and `VISUAL` is set to "nano," to define the default pager and editor. Finally, `api_keys` are loaded into `MY_ENV_VARS` from an encrypted JSON file.

### gcal
These nushell custom functions provide a convenient wrapper for interacting with Google Calendar using the `gcalcli` tool. They enable users to add events, as well as view their agenda, weekly, or monthly calendar, with options to specify details such as calendar selection, event title, date, location, and duration. The functions are flexible, allowing for both full calendar visibility and the inclusion of additional flags for detailed customization. Users can also invoke these commands without arguments, prompting them for the necessary inputs. Overall, these functions are designed to streamline the process of managing Google Calendar events directly from nushell.

### geek
These custom nushell functions provide a suite of tools designed to interface with the Geeknote command-line client for Evernote. They offer a variety of operations such as searching for notes with "geek find," displaying note content with "geek show," editing notes via "geek edit," and creating new notes using "geek create." Additionally, there is a function for exporting notes to ENEX files named `geek export`, which automatically installs the necessary `evernote-backup` package if it isn't already present. These functions streamline the process of managing Evernote notes from the command line, adding extra features like handling additional flags and formatting output for improved readability.

### get-ips
The custom Nushell function outlined here is designed to determine both the internal and external IP addresses of a device. It takes an optional parameter to specify the network device, defaulting to 'wlo1' for Wi-Fi or 'eno1' for a LAN connection, based on the hostname and a predefined environment variable. The function retrieves the system's hostname and decides the network device based on the provided argument or environment settings. It then fetches the local (internal) IP address corresponding to the chosen network device and queries an external service to get the external IP address. The function returns a JSON object containing both IP addresses. This script is used by `pre_execution_hook.nu`.

### github
These custom functions facilitate various scripting operations related to repository management and file synchronization. They include a function to selectively copy non-private scripts from a private directory to a public repository and commit the changes. Another function clones a private backup repository of Ubuntu onto the local machine. There's also an alias named `quantum` that updates a private repository with the contents of a private Linux backup directory, with options to force the copy, update the public nushell scripts repository, and upload Debian package files to Google Drive. Lastly, there's a function dedicated to uploading new or updated Debian package files to Google Drive if they are newer than the files already present, ensuring that the remote storage is kept current with local changes. These functions are designed to streamline the process of maintaining and synchronizing script files and software backups between local and remote locations.

### jdown
This script is a Python-based wrapper for JDownloader, using the `myjdapi` library to interact with JDownloader instances. It defines a main function that handles command-line arguments to select a specific JDownloader device configuration, connects to a given user's JDownloader account, retrieves the device using its label (which could be 'dev1' or 'dev2'), and queries the download packages. It compiles detailed information about each download, including UUID, name, host, child count, ETA, speed, and the amount of data loaded versus the total data size (both in megabytes), and outputs this as a JSON-formatted list. If no downloads are found or the specified device is not found, it prints an appropriate message and exits. The script is meant to be executed directly and requires the `myjdapi` library to be installed.

### lister
This script offer a set of file manipulation and information retrieval capabilities within a specified directory structure. The `main` function processes a JSON file from a given directory, extracts and manipulates file path information, and ultimately saves the processed data back into a structured file format. It involves getting a list of files, dropping certain attributes, parsing file paths, and renaming components before appending the information into a final format. The `get-files` function is a utility that facilitates the recursive listing of files in directories, with options to include full paths, target specific directories, and filter for files only, which can then be sorted by name. The commands allow for flexible and powerful batch processing of file data in a user's environment.

### maths
The collection of custom functions for Nushell includes a variety of mathematical operations. These functions allow users to perform root calculations with customizable denominators and scalars, compute cube roots, factorials, and check for prime numbers, as well as generate lists of primes up to a specified limit. Users can calculate roots of quadratic equations, create multiplication tables up to a given number, determine if a year is a leap year, and find the greatest common divisor (GCD) and least common multiple (LCM) of two integers. Conversion between decimal and custom base representations is supported, and functions for scaling numerical lists or table columns to a specified interval are included. Additional functions cover calculating the exponential function, selecting random integers or elements from a list, computing binomial coefficients, permutations, the Fibonacci sequence, and statistical measures such as skewness and kurtosis of numerical data.

### media
These nushell custom functions provide a comprehensive suite of media manipulation tools that require dependencies such as `ffmpeg`, `sox`, `subsync`, and `mpv`. These functions allow users to perform a variety of actions on media files, including but not limited to: obtaining media information, translating and syncing subtitles, removing audio noise from both audio and video files, screen recording, stripping audio from video, cutting and splitting video and audio files, extracting audio, merging videos, and compressing videos. Additional features include searching media databases, handling downloaded YouTube content, and notifying an Android device via Join upon task completion. The functions are designed to handle different file types and provide options for output formats, encoding settings, and language support for subtitles.

### net
This script invokes `nethogs` to monitor network traffic, processes the output, and formats it before saving it to a file. Specifically, the script captures the first five entries of network traffic data, cleans up process names, pads the upload and download rates for alignment, and then consolidates the data into a formatted string with the process name followed by the upload and download rates, separated by colons. The formatted data is joined by newlines and saved to a designated file in the user's home directory, appending a newline character each time the script runs. This script is used in the `.conkyrc` file.

### network
These custom functions serve a variety of network-related purposes. They enable users to switch to a stronger known Wi-Fi network, display detailed Wi-Fi connection information with visual enhancements for the active connection, list used network sockets by process, and fetch internal and external IP addresses with optional device specification. Other functions include identifying devices connected to the network using `nmap`, retrieving saved Wi-Fi passwords from system configurations, and displaying stored IP addresses in a table format. These utilities facilitate network management and information retrieval, enhancing user experience on systems that support NuShell scripts.

### plots
These custom functions are designed to visualize various types of data through different plotting methods. The `png-plot` function uses the `ping` command to check network latency to a specified IP address and plots the results in real-time. The `speedtest-plot` function measures and plots both download and upload internet speeds. The `gnu-plot` function generates plots from one or two-column data tables using `gnuplot`, with options to set titles and label axes, while the `plot-table` function creates plots from table data using a plugin, with customization options for the type of plot, title, and width. Each function enhances the visualization of data in the terminal, allowing users to understand and analyze data more effectively through graphical representations.

### pre_execution_hook
These custom functions are designed to automate system tasks related to file management and network information updating. Initially, the script checks for the existence of a data file and copies it from a backup location if it's not found. It then determines whether a certain time interval has passed to decide if it should update a list of mounted drives and directories. If an update is due, it executes another script and updates a JSON file with the current date and time. Additionally, if the update condition is met, the script retrieves and updates the device's IP address information, echoing a message in green, storing the hostname, and updating an IPs JSON file with the latest network information obtained from yet another script. The process involves reading, modifying, and saving JSON files and executing external Nu scripts.

### progressbar
These custom functions provide various utilities for displaying progress indicators and managing cursor visibility in a terminal. They include functions to generate text-based progress bars with customizable symbols, colors, and percentage displays; a more detailed progress bar with incremental blocks that fill up over time; a loading function that updates the percentage complete; and functions to hide and show the terminal cursor. Additionally, there is a utility for formatting floating-point numbers with specified precision and padding. These functions enhance the user experience in command-line interfaces by providing visual feedback on the progress of operations and improving the readability of numerical output.

### string_manipulation
These nushell custom functions facilitate string manipulation, text processing, date and time conversion, and visual output enhancement. They offer ways to prepend or append strings, repeat strings a specified number of times, and remove accents from characters. Additionally, they can convert time in the format `hh:mm:ss` to a duration and vice versa. One function extracts the first HTTP link from text and opens it, while another formats dates in a custom pattern and can be used for renaming files with date information. Lastly, there is a progress bar generator that displays a progress bar on the terminal with customizable symbols, colors, and background, adjusting dynamically to the terminal size and task progress. These functions are versatile tools designed to streamline various tasks in shell scripting with nushell.

### system
These nushell custom functions offer a variety of utilities for system information and environment management. They include functions to display a colorful banner with system details, fetch system information similar to `neofetch`, handle prompts, provide help for commands, access command history with syntax highlighting, search and manage processes, manipulate paths and directories, get aliases and source code for custom commands, control network applications, arrange multiple displays, unmount drives, fix Docker permissions, and handle errors. These functions are designed to enhance user interaction with the shell, streamline system monitoring, and facilitate easy navigation and control of the operating environment.

### table_manipulation
These functions for nushell facilitate various data manipulation tasks: converting ranges to lists, cleaning up ANSI escape codes from tables, adding hidden index columns to tables, filtering for unique rows by a specified column, summing file sizes from `ls` output, transforming tables into records, calculating set differences, finding index positions of search terms, extracting and transforming table columns into tables or lists, merging and deduplicating lists, retrieving specific rows from a table based on indexes, interactively selecting columns from a table, and setting default values across entire tables. These utilities enhance nushell's capabilities by streamlining common operations on tables, lists, and text, making data processing more efficient.

### tasker
These functions provide a suite of tools for interacting with devices using the Join app, offering a variety of methods for remote communication and control. The functions allow users to send notifications, initiate phone calls, utilize text-to-speech (TTS), and send SMS messages from a specified device, with the option to select a device interactively. These functions interact with the Join API, requiring an API key and device ID, and they support encoding text and title information for network transmission. Parameters can be set for specifying devices, choosing a language for TTS, and customizing other aspects of the communication. Additionally, the help function provides an overview of the available methods and their usage.

### transmission
These custom functions serve as a wrapper for managing Transmission, a BitTorrent client, through the command line. These functions allow users to control and interact with the Transmission daemon and include capabilities such as starting and stopping the daemon, reloading its configuration, and listing currently managed torrents. Users can also retrieve basic or full statistics for the torrents, open a text-based user interface for Transmission, and add torrents to the download queue either individually or in bulk from a file. Additionally, the functions support fetching information about specific torrents, removing torrents from the queue with or without deleting associated files, removing completed torrents, and initiating or halting the download of torrents either individually or collectively. These utilities provide a convenient and scriptable way to handle torrent activities directly from the shell environment.

### update_apps
These nushell custom functions collectively handle software updates and installations for various applications, both on and off the package manager as well as custom functions to fetch the latest release information from GitHub repositories, and to update GitHub app releases. Other functions deal with updating utilities and tools like nchat, ffmpeg with CUDA support, whisper, manim, yewtube, yt-dlp, and Joplin, as well as registering nushell plugins, upgrading the system, upgrading pip3 packages, updating the nushell config, installing fonts, and handling errors during installations. Each function encapsulates the necessary steps to check for updates, download new versions, and install them, often with error handling to notify the user if something goes wrong.

### update_right_prompt
This script sets up an environment variable named `MY_ENV_VARS`. Within this, it defines or updates the `l_prompt` field. The `l_prompt` field is toggled between "short" and "long" based on its current state. If it does not exist or is empty, or if it is currently set to "short", it will be set to "long". If it is already set to "long", it will be changed back to "short". This script ensures that `l_prompt` alternates between these two states, presumably to adjust the prompt length in the user's shell environment.

### weather_tomorrow
These functions collectively form a comprehensive weather reporting tool. The functions allow users to retrieve weather forecasts and current conditions based on their IP address or specified location. The tool uses APIs like tomorrow.io for weather data and deprecated airvisual for air pollution, alongside Google Maps API for street addresses. The script supports various functionalities such as fetching weather at intervals for the command prompt, providing detailed descriptions of wind and UV conditions, and displaying air quality levels. There is also a plotting feature for visualizing weather data if the system supports it. Version 2.0 of the weather script features the ability to customize the home location, check network status before fetching data, and gracefully handle errors or lack of data. Users can also explore detailed weather conditions and forecasts, such as temperature, humidity, sunrise and sunset times, and wind speeds, as well as see a text representation of current weather conditions with an icon.

### yandex
These nushell custom functions serve as wrappers for the Yandex Disk CLI app, offering simplified commands to manage and interact with Yandex Disk. These commands include checking the status of the synchronization and space usage, starting and stopping the synchronization process, accessing the help menu, and listing the last synchronized items. The status function filters the output to show sync-related information and space usage, the start and stop functions control the sync process, the help function displays the help options, and the last function presents the most recent files that were synchronized.

### yt_api
These custom functions provide a suite of tools for interacting with the YouTube API and managing YouTube music playlists. They enable users to configure credentials, create and refresh API tokens, and handle token expiration. The functions include methods for playing YouTube music from a local database or directly from YouTube, downloading music playlists to a local database, updating playlists with new likes, and removing duplicates or all songs from a playlist. Additional commands allow for verifying token validity, getting and refreshing tokens, and testing API interactions. Helper commands such as `yt-api help` provide more information on usage, and related commands like `ytm` are also mentioned. The functions are designed to work with YouTube playlists, allowing fetching of playlist items, updating playlists, and managing songs with various filters and options.

### zoxide
These custom functions offer enhanced directory navigation capabilities. They allow users to quickly jump to directories using keywords or an interactive search interface. The first function defines a command that accepts one or more keywords to identify and change to a target directory, handling cases where the path needs expansion or querying a database. The second function presents an interactive search method, where users can select from a list of directories that match the input criteria. Both functions integrate with `zoxide`, a smarter `cd` command, and use fuzzy matching to improve the user experience. Additionally, there's a completion function designed to suggest directory paths based on the user's input, further aiding navigation by providing real-time, context-aware options. Taken from the official zoxide repository.

# Disclaimers
- Some of these have been taken from the `#cool-scripts` Discord channel of Nushell ;)
- Each file summary was generated by gpt-4-turbo.
