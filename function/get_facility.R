facility <- function(addr, Lon, Lat){
  area <- substr(addr,1,3)
  Bus_stop_area <- Bus_stop[Bus_stop$area == area,]
  Car_park_area <- Car_park[Car_park$area == area,]
  Child_care_center_area <- Child_care_center[Child_care_center$area == area,]
  Cinema_area <- Cinema[Cinema$area == area,]
  clinic_area <- clinic[clinic$area == area,]
  Department_store_area <- Department_store[Department_store$area == area,]
  District_Office_area <- District_Office[District_Office$area == area,]
  Elderly_care_area <- Elderly_care[Elderly_care$area == area,]
  Fire_brigade_area <- Fire_brigade[Fire_brigade$area == area,]
  Funeral_industry_area <- Funeral_industry[Funeral_industry$area == area,]
  GAS_area <- GAS[GAS$area == area,]
  High_School_area <- High_School[High_School$area == area,]
  hospital_area <- hospital[hospital$area == area,]
  Hypermarkets_area <- Hypermarkets[Hypermarkets$area == area,]
  Incinerator_area <- Incinerator[Incinerator$area == area,]
  Library_area <- Library[Library$area == area,]
  MRT_area <- MRT[MRT$area == area,]
  Nursery_area <- Nursery[Nursery$area == area,]
  Park_area <- Park[Park$area == area,]
  Physical_and_mental_mechanism_area <- Physical_and_mental_mechanism[Physical_and_mental_mechanism$area == area,]
  Police_station_area <- Police_station[Police_station$area == area,]
  Primary_school_area <- Primary_school[Primary_school$area == area,]
  Secondary_School_area <- Secondary_School[Secondary_School$area,]
  Store_area <- Store[Store$area == area,]
  Supermarket_area <- Supermarket[Supermarket$area == area,]
  Temp_area <- Temp[Temp$area == area,]
  Traditional_markets_area <- Traditional_markets[Traditional_markets$area == area,]
  Tutoring_area <- Tutoring[Tutoring$area == area,]
  University_area <- University[University$area == area,]
  Wastewater_area <- Wastewater[Wastewater$area == area,]
  
  dist_Bus_stop <- numeric(length(Bus_stop_area[,1]))
  dist_Car_park <- numeric(length(Car_park_area[,1]))
  dist_Child_care_center <- numeric(length(Child_care_center_area[,1]))
  dist_Cinema <- numeric(length(Cinema_area[,1]))
  dist_clinic <- numeric(length(clinic_area[,1]))
  dist_Department_store <- numeric(length(Department_store_area[,1]))
  dist_District_Office <- numeric(length(District_Office_area[,1]))
  dist_Elderly_care <- numeric(length(Elderly_care_area[,1]))
  dist_Fire_brigade <- numeric(length(Fire_brigade_area[,1]))
  dist_Funeral_industry <- numeric(length(Funeral_industry_area[,1]))
  dist_GAS <- numeric(length(GAS_area[,1]))
  dist_High_School <- numeric(length(High_School_area[,1]))
  dist_hospital <- numeric(length(hospital_area[,1]))
  dist_Hypermarkets <- numeric(length(Hypermarkets_area[,1]))
  dist_Incinerator <- numeric(length(Incinerator_area[,1]))
  dist_Library <- numeric(length(Library_area[,1]))
  dist_MRT <- numeric(length(MRT_area[,1]))
  dist_Nursery <- numeric(length(Nursery_area[,1]))
  dist_Park <- numeric(length(Park_area[,1]))
  dist_Physical_and_mental_mechanism <- numeric(length(Physical_and_mental_mechanism_area[,1]))
  dist_Police_station <- numeric(length(Police_station_area[,1]))
  dist_Primary_school <- numeric(length(Primary_school_area[,1]))
  dist_Secondary_School <- numeric(length(Secondary_School_area[,1]))
  dist_Store <- numeric(length(Store_area[,1]))
  dist_Supermarket <- numeric(length(Supermarket_area[,1]))
  dist_Temp <- numeric(length(Temp_area[,1]))
  dist_Traditional_markets <- numeric(length(Traditional_markets_area[,1]))
  dist_Tutoring <- numeric(length(Tutoring_area[,1]))
  dist_University <- numeric(length(University_area[,1]))
  dist_Wastewater <- numeric(length(Wastewater_area[,1]))
  
  for (i in 1:length(Store_area[,1])) {
    if (length(Store_area[,1]) == 0){break}
    else{dist_Store[i] <- gdist(Lon,Lat,Store_area$Longitude[i],Store_area$Latitude[i],units = "m")}
  }
  if (length(Store_area[,1]) == 0){
    return(0)} else{Store_area <- cbind(Store_area, dist_Store);
    Store_500 <- subset(Store_area,dist_Store<500);return(Store_500)}
  
  
  
}