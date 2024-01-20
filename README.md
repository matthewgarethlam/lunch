## What is this?
In the Brum office, the grads have "New Foods Friday", where we go and try out lunch from a new food establishment every Friday. We score it based on several criteria and is all collated in a spreadsheet. This data is used to produce this map, accessible at: https://matthewgarethlam.github.io/lunch/

## Technical details
Written in R, uses ```tmap```, published via GitHub Pages. Site ```index.html``` (i.e., the map) is found in ```/docs```. The file ```makemap.yaml```re-runs the R Script on push to the main branch, and the Github site will update after map has been output. 

## Maintenece
New data should go in ```data.csv```. Push changes to main branch and the GH action workflow will be run. 

NB: 
```R
#tmap mode must be in view! 
tmap_mode("view") 
```

## Dependencies
```R
install.packages(c("tidyverse","osrm", "sf","tmap","leaflet"))
```
