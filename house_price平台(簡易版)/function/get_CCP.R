get_CCP <- function(village, town, data){
  ccp <- if (nchar(village) == 0){
    area_data <- data[data$area == town,]
    area_mean <- mean(area_data$CCP)} else {
      village_data <- data[data$village == village,]
      village_ccp <- village_data$CCP}
  return(ccp)
}

