# ntfy.sh *arr script

Quick and hacky bash script to get sonarr/radarr to notify the ntfy.sh service.

This is for my own use and so I haven't added any event types beyond import/download. You could easily add additional events using a case statement.

## Quick Start

Clone this repo:

```bash
git clone https://github.com/agent-squirrel/nfty-arr-script
```

Edit the config file and replace as appropriate:

```bash
vim config
```

```bash
username=someuser
password=somepass
endpoint=yourntfyendpoint.com
domain=yourdomain.com
topic=somentfytopic
```

Put the script and the config somewhere that Sonarr/Radarr can execute it.
In the case of Docker, you can mount the directory into the container, a docker-compose sample it below:

```docker
version: "2.1"
services:
  sonarr:
    image: linuxserver/sonarr
    container_name: sonarr
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Australia/Hobart
      - UMASK_SET=022 #optional
    volumes:
      - /opt/sonarr/config:/config
      - /opt/sonarr/tv:/tv
      - /opt/deluge/downloads:/downloads
      - /opt/custom_scripts:/config/custom_scripts
    ports:
      - 8989:8989
    restart: unless-stopped
```

In this example the location is /opt/custom_scripts.

Set Sonarr/Radarr to use the new script:

1. Navigate to settings -> Connect
  
2. Click the + icon
  
3. Choose "Custom Script"
  
4. Give the integration a name
  
5. Uncheck all triggers except "On Download" unless you have added this functionality to the script
  
6. Optionally add tags
  
7. In the path box, either manually type the path out or use the folder icon to browse to the script
