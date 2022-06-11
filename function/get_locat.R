get_locat <- function(addr, api_key) {

  x <- ""
  locatxy <- c(0,0)
  
  aa <- ""
  aa <- addr
  
  xxx <- URLencode(aa)
  x <- as.character(paste0("Taiwan",xxx))
  api_key <- as.character(api_key)
  locat <- paste0('http://maps.googleapis.com/maps/api/geocode/json?address=', x, '&sensor=false&APIKEY=', api_key)
  
  x1 = getURI(locat,.encoding = "UTF-8")
  
  y1 = fromJSON(x1)
  
  x2 <- y1$results[[1]]$geometry$location$lat
  y2 <- y1$results[[1]]$geometry$location$lng
  
  locatxy <-c(y2,x2)
}
