# TFS-Multiclient-Discord
Get notification on your discordserver when someone is using multiclient!

![image](https://github.com/crilleaz/TFS-Multiclient-Discord/assets/20803604/4fdcca16-776c-482c-aadc-2f3a40c7003f)


### Installation

1. Clone the repository
```
git clone https://github.com/crilleaz/TFS-Multiclient-Discord
```

2. Setup
```
Move content of globalevents/scripts into your TFS1.*-server, replace existing ones
Update globalevents.xml (see example in globalevents.xml)
Import mc_check.sql into your database
Edit database details and discord webhook in dc_offload_multiclients.php

Add cronjob for the webhook:
$sudo crontab -e
* * * * * php -e /path/to/dc_offload_multiclients.php
```

### Discord
Crille#6623
