## What is this?
In the Brum office, the grads have "New Foods Friday", where we go and try out lunch from a new food establishment every Friday. We score it based on several criteria and is all collated in a spreadsheet. This data is used to produce this map, accessible at: https://matthewgarethlam.github.io/lunch/

## Technical details
Written in R, uses ```tmap```, published via GitHub Pages. Site ```index.html``` (i.e., the map) is found in ```/docs```

## Maintenece
New data should go in ```data.csv```, and then ```makelunchmap.R``` should be run to update the map.
```R
#tmap mode must be in view! 
tmap_mode("view") 
```

## Dependencies
```R
install.packages(c("osmdata", "tidyverse","osrm", "sf","tmap","tidygeocoder", "leaflet"))
```
