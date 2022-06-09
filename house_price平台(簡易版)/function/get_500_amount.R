get_500_amout <- function(town, area, lon, lat, data){
  if (length(data[,1]) <= 1500){
    data_town <- data[data$town == town,]
    number <- numeric(length(data_town[,1]))
    for(i in 1:length(data_town[,1]))
    {
      distance <- gdist(lon,lat,data_town$Longitude[i],data_town$Latitude[i],units = "m")
      if (distance < 500){number[i] <- 1}
      else {number[i] <- 0}
    }
    amount <- sum(number)
    site <- which(number == 1)
    site_data <- data_town[c(site),]
    site_data_fin <- data.frame(type = site_data$type, name = site_data$name, address = site_data$address)
  }
  else {
    data_town <- data[data$town == town,]
    data_area <- data_town[data_town$area == area,]
    number <- numeric(length(data_area[,1]))
    for(i in 1:length(data_area[,1]))
    {
      distance <- gdist(lon,lat,data_area$Longitude[i],data_area$Latitude[i],units = "m")
      if (distance < 500){number[i] <- 1}
      else {number[i] <- 0}
    }
    amount <- sum(number)
    site <- which(number == 1)
    site_data <- data_area[c(site),]
    site_data_fin <- data.frame(type = site_data$type, name = site_data$name, address = site_data$address)
  }
  final_data <- list(amount, site_data_fin)
  return(final_data)
}