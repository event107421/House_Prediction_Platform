get_min_dist <- function(town, area, lon, lat, data){
  if (length(data[,1]) <= 1500){
    data_town <- data[data$town == town,]
    distance <- numeric(length(data_town[,1]))
    for(i in 1:length(data_town[,1]))
    {
      distance[i] <- gdist(lon,lat,data_town$Longitude[i],data_town$Latitude[i],units = "m")
      gdist <- min(distance)
    }
    site <- which.min(distance)
    site_data <- data_town[site,]
    site_data_fin <- data.frame(type = site_data$type, name = site_data$name, address = site_data$address)
  }
  else {
    data_town <- data[data$town == town,]
    data_area <- data_town[data_town$area == area,]
    distance <- numeric(length(data_area[,1]))
    for(i in 1:length(data_area[,1]))
    {
      distance[i] <- gdist(lon,lat,data_area$Longitude[i],data_area$Latitude[i],units = "m")
      gdist <- min(distance)
    }
    site <- which.min(distance)
    site_data <- data_area[site,]
    site_data_fin <- data.frame(type = site_data$type, name = site_data$name, address = site_data$address)
  }
  final_data <- list(gdist, site_data_fin)
  return(final_data)
}
