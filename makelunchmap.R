library(osmdata)
library(tidyverse)
library(osrm)
library(sf)
library(tmap)
tmap_mode("view")
library(tidygeocoder)
library(leaflet)



#office address
office_address <- tibble::tribble(
  ~name,                  ~addr,
  "10 Livery Street",          "10 Livery Street, Birmingham, UK "
)


office_coords <- office_address %>% geocode(addr,method = 'osm', lat = latitude , long = longitude)
office_coords

office_point <- office_coords %>% st_as_sf(coords = c( "longitude", "latitude"))



#calculate walkability
walk_iso <- osrmIsochrone(loc=c(office_coords$longitude, office_coords$latitude),breaks=c(0,2,4,6,8,10), osrm.profile = "foot")
walk_iso<- walk_iso %>% rowwise() %>% mutate(walk_time_mins = paste0(as.character(min),"-",as.character(max))) 
walk_iso$walk_time_mins <- factor(walk_iso$walk_time_mins, levels=c("0-2","2-4", "4-6","6-8", "8-10"))
walk_iso$id <- walk_iso$walk_time_mins


#pull osm data
# bbox = st_bbox(walk_iso) %>% st_as_sfc()
# 
# x <- opq(bbox) %>%
#   add_osm_feature (
#     key = "amenity",
#     value = c("restaurant", "fast_food", "cafe")) %>%
#   
#   osmdata_sf() 
# 
# points <- x$osm_points


#read in chris's excel data
data <- read.csv("data.csv")
for(i in 1:nrow(data)){
  data$lat[i] <- as.numeric(strsplit(data$Coords[i], split=",")[[1]][1])
  data$lon[i] <- as.numeric(strsplit(data$Coords[i], split=",")[[1]][2])
  
}

data$Total.Score <- as.numeric(data$Total.Score)


restaurant_points <- data %>% st_as_sf(coords=c("lon", "lat"))




#the map
mypal = c("#f3e79b","#f8a07e","#ce6693","#a059a0","#5c53a5")
mypal2 = c("#009392","#39b185","#9ccb86","#e9e29c","#eeb479","#e88471","#cf597e")



map <- tm_basemap(leaflet::providers$CartoDB) +
tm_shape(walk_iso)+tm_polygons("walk_time_mins", palette=mypal, alpha=0.4, lwd=0.05,popup.vars=c("Walk Time (Mins)" = "walk_time_mins"), title="Walk Time (Mins)")+
tm_shape(restaurant_points)+tm_dots(col="Total.Score", size=0.15, palette = "RdYlGn",  style="pretty",
                                                                                                popup.vars=c("Total Score"="Total.Score", 
                                                                                                "Taste"="Taste", 
                                                                                                "Variety"="Variety",
                                                                                                "Cost" = "Cost",
                                                                                                "Distance" = "Distance",
                                                                                                "Customer Service" = "Customer.Service"), title="Total Score")+
  tm_shape(office_point) + tm_markers()










