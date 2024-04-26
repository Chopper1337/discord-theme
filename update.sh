#!/bin/bash

touch theme.css || exit

# Build HorizontalServerList
(cd HorizontalServerList && npm i && npm run build)

# Create theme.css
cat HorizontalServerList/dist/dist/HorizontalServerList.css > theme.css
printf "\n" >> theme.css
cat midnight-discord/midnight.css >> theme.css
printf "\n" >> theme.css
cat amoled-cord/src/amoled-cord.css >> theme.css
