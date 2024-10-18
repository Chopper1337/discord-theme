#!/bin/bash

deps=( git minify )

for dep in ${deps[@]}
do 
  which $dep || exit
done

# Only run the script from the directory of the repo
cd $(cd "${0%/*}" && echo $PWD) || exit

git submodule update --remote --merge

touch theme.css || exit

# Build HorizontalServerList
(cd HorizontalServerList && npm i && npm run build)

# Create theme.css
cat HorizontalServerList/dist/dist/HorizontalServerList.css > theme.css || echo "Failed to add HorizontalServerList.css to theme.css"
printf "\n" >> theme.css
cat midnight-discord/midnight.css >> theme.css || echo "Failed to add midnight-discord/midnight.css to theme.css"
printf "\n" >> theme.css
cat amoled-cord/src/amoled-cord.css >> theme.css || echo "Failed to add amoled-cord.css to theme.css"

minify theme.css > theme.min.css || echo "Failed to minify theme.css"

rm theme.css
