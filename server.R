source("function/get_locat.R", encoding = "UTF-8")
source("function/get_min_dist.R", encoding = "UTF-8")
source("function/get_500_amount.R", encoding = "UTF-8")
source("function/get_CCP.R", encoding = "UTF-8")
source("function/get_yungching_web.R", encoding = "UTF-8")
load("model/model_data.RData")

busstop <- makeIcon(iconUrl="https://openclipart.org/download/29286/Rfc1394-Bus-Shelter.svg", iconWidth = 32, iconHeight = 32)
carpark <- makeIcon(iconUrl="https://openclipart.org/download/50497/26-Hotel-Icon-Has-Parking.svg", iconWidth = 32, iconHeight = 32)
child <- makeIcon(iconUrl="https://openclipart.org/download/222193/Vintage-Baby-Carriage-Silhouette.svg", iconWidth = 32, iconHeight = 32)
cinem <- makeIcon(iconUrl="https://openclipart.org/download/7878/paulprogrammer-Popcorn.svg", iconWidth = 32, iconHeight = 32)
clin <- makeIcon(iconUrl="https://openclipart.org/download/270661/Stethoscope.svg", iconWidth = 32, iconHeight = 32)
depart <- makeIcon(iconUrl="https://openclipart.org/download/21547/buggi-build.svg", iconWidth = 32, iconHeight = 32)
office <- makeIcon(iconUrl="https://openclipart.org/download/216806/office-building.svg", iconWidth = 32, iconHeight = 32)
elderly <- makeIcon(iconUrl="https://openclipart.org/download/168491/Nurse-Practise.svg", iconWidth = 32, iconHeight = 32)
fire <- makeIcon(iconUrl="https://openclipart.org/download/190874/Fire-truck.svg", iconWidth = 32, iconHeight = 32)
funeral <- makeIcon(iconUrl="https://openclipart.org/download/271824/RIP-graveside-marker.svg", iconWidth = 32, iconHeight = 32)
gas <- makeIcon(iconUrl="https://openclipart.org/download/35725/gaspump.svg", iconWidth = 32, iconHeight = 32)
school <- makeIcon(iconUrl="https://openclipart.org/download/265939/1478620819.svg", iconWidth = 32, iconHeight = 32)
hospi <- makeIcon(iconUrl="https://openclipart.org/download/265320/hospital-2.svg", iconWidth = 32, iconHeight = 32)
hyper <- makeIcon(iconUrl="https://openclipart.org/download/98839/roboshopper.svg", iconWidth = 32, iconHeight = 32)
inciner <- makeIcon(iconUrl="https://openclipart.org/download/3822/Sabathius-Fire-warning-symbol.svg", iconWidth = 32, iconHeight = 32)
library <- makeIcon(iconUrl="https://openclipart.org/download/173650/library-pictogram.svg", iconWidth = 32, iconHeight = 32)
mrt <- makeIcon(iconUrl="https://openclipart.org/download/25364/aiga-rail-transportation.svg", iconWidth = 32, iconHeight = 32)
nurser <- makeIcon(iconUrl="https://openclipart.org/download/25162/aiga-nursery.svg", iconWidth = 32, iconHeight = 32)
par <- makeIcon(iconUrl="https://openclipart.org/download/166246/greenparking.svg", iconWidth = 32, iconHeight = 32)
phy <- makeIcon(iconUrl="https://openclipart.org/download/173655/wheelchair-pictogram.svg", iconWidth = 32, iconHeight = 32)
police <- makeIcon(iconUrl="https://openclipart.org/download/173188/badge.svg", iconWidth = 32, iconHeight = 32)
stor <- makeIcon(iconUrl="https://openclipart.org/download/76267/shop.svg", iconWidth = 32, iconHeight = 32)
super <- makeIcon(iconUrl="https://openclipart.org/download/60091/cart3.svg", iconWidth = 32, iconHeight = 32)
temple <- makeIcon(iconUrl="https://openclipart.org/download/101359/chinese-architecture.svg", iconWidth = 32, iconHeight = 32)
tradition <- makeIcon(iconUrl="https://openclipart.org/download/183033/jiangyi-99-basket-of-vegetables.svg", iconWidth = 32, iconHeight = 32)
tutor <- makeIcon(iconUrl="https://openclipart.org/download/194249/tutor-and-student.svg", iconWidth = 32, iconHeight = 32)
university <- makeIcon(iconUrl="https://openclipart.org/download/60307/student-hat-2.svg", iconWidth = 32, iconHeight = 32)
waste <- makeIcon(iconUrl="https://openclipart.org/download/169873/gsagri04-Recycle-water.svg", iconWidth = 32, iconHeight = 32)

shinyServer(function(input, output) {
  #預測台北房價
  pred_house_price <- eventReactive(input$taipei_predic,{
    addr <- paste0("台北市", input$area, input$Address)
    locat <- get_locat(addr)
    Bus_Stop_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2], Bus_stop)
    Car_park_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Car_park)
    Child_care_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Child_care_center)
    Cinema_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Cinema)
    clinic_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],clinic)
    Department_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Department_store)
    District_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],District_Office)
    Elderly_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Elderly_care)
    Fire_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Fire_brigade)
    Funeral_industry_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Funeral_industry)
    GAS_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],GAS)
    High_School_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],High_School)
    hospital_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],hospital)
    Hypermarkets_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Hypermarkets)
    Incinerator_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Incinerator)
    Library_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Library)
    MRT_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],MRT)
    Nursery_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Nursery)
    Park_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Park)
    Physical_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Physical_and_mental_mechanism)
    Police_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Police_station)
    Primary_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Primary_school)
    Secondary_School_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Secondary_School)
    Store_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Store)
    Supermarket_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Supermarket)
    Temp_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Temp)
    markets_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Traditional_markets)
    Tutoring_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Tutoring)
    University_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],University)
    Wastewater_dist_data <- get_min_dist("台北市", input$area, locat[1],locat[2],Wastewater)
    
    Bus_Stop_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Bus_stop)
    Car_park_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Car_park)
    Child_care_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Child_care_center)
    Cinema_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Cinema)
    clinic_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], clinic)
    Department_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Department_store)
    District_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], District_Office)
    Elderly_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Elderly_care)
    Fire_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Fire_brigade)
    Funeral_industry_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Funeral_industry)
    GAS_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], GAS)
    High_School_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], High_School)
    hospital_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], hospital)
    Hypermarkets_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Hypermarkets)
    Incinerator_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Incinerator)
    Library_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Library)
    MRT_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], MRT)
    Nursery_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Nursery)
    Park_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Park)
    Physical_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Physical_and_mental_mechanism)
    Police_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Police_station)
    Primary_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Primary_school)
    Secondary_School_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Secondary_School)
    Store_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Store)
    Supermarket_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Supermarket)
    Temp_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Temp)
    markets_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Traditional_markets)
    Tutoring_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Tutoring)
    University_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], University)
    Wastewater_amount_data <- get_500_amout("台北市", input$area, locat[1], locat[2], Wastewater)
    
    CCP <- get_CCP(input$village, input$area, CCP_data)
    
    area <- input$area
    building_type <- input$building_type
    Management_organization <- input$Management_organization
    use_separation <- input$use_separation
    main_use <- input$main_use
    building_materials <- input$building_materials
    land_transfer <- input$land_transfer
    building_transfer <- input$building_transfer
    floor_transfer <- input$floor_transfer
    total_floor <- input$total_floor
    rooms <- input$rooms
    halls <- input$halls
    bathrooms <- input$bathrooms
    house_age <- input$house_age
    
    data <- data.frame(area,land_transfer,building_type,Management_organization,building_transfer,use_separation,floor_transfer,total_floor,main_use,
                       building_materials,rooms,halls,bathrooms,house_age,Bus_Stop_dist = Bus_Stop_dist_data[[1]],Car_park_dist = Car_park_dist_data[[1]],
                       GAS_dist = GAS_dist_data[[1]],High_School_dist = High_School_dist_data[[1]],Incinerator_dist = Incinerator_dist_data[[1]],Library_dist = Library_dist_data[[1]],
                       MRT_dist = MRT_dist_data[[1]],Nursery_dist = Nursery_dist_data[[1]],Park_dist = Park_dist_data[[1]],Primary_dist = Primary_dist_data[[1]],
                       Secondary_School_dist = Secondary_School_dist_data[[1]],Temp_dist = Temp_dist_data[[1]],University_dist = University_dist_data[[1]],
                       Wastewater_dist = Wastewater_dist_data[[1]],Elderly_dist = Elderly_dist_data[[1]],Department_dist = Department_dist_data[[1]],Physical_dist = Physical_dist_data[[1]],
                       Fire_dist = Fire_dist_data[[1]],District_dist = District_dist_data[[1]],Cinema_dist = Cinema_dist_data[[1]],Police_dist = Police_dist_data[[1]],markets_dist = markets_dist_data[[1]],
                       Child_care_dist = Child_care_dist_data[[1]],Funeral_industry_dist = Funeral_industry_dist_data[[1]],Supermarket_dist = Supermarket_dist_data[[1]],
                       hospital_dist = hospital_dist_data[[1]],Hypermarkets_dist = Hypermarkets_dist_data[[1]],Store_dist = Store_dist_data[[1]],Tutoring_dist = Tutoring_dist_data[[1]],
                       clinic_dist = clinic_dist_data[[1]],CCP,Bus_Stop_amount = Bus_Stop_amount_data[[1]],Car_park_amount = Car_park_amount_data[[1]],GAS_amount = GAS_amount_data[[1]],
                       High_School_amount = High_School_amount_data[[1]],Incinerator_amount = Incinerator_amount_data[[1]],Library_amount = Library_amount_data[[1]],MRT_amount = MRT_amount_data[[1]],
                       Nursery_amount = Nursery_amount_data[[1]],Park_amount = Park_amount_data[[1]],Primary_amount = Primary_amount_data[[1]],Secondary_School_amount = Secondary_School_amount_data[[1]],
                       Temp_amount = Temp_amount_data[[1]],University_amount = University_amount_data[[1]],Wastewater_amount = Wastewater_amount_data[[1]],Elderly_amount = Elderly_amount_data[[1]],
                       Department_amount = Department_amount_data[[1]],Physical_amount = Physical_amount_data[[1]],Fire_amount = Fire_amount_data[[1]],District_amount = District_amount_data[[1]],
                       Cinema_amount = Cinema_amount_data[[1]],Police_amount = Police_amount_data[[1]],markets_amount = markets_amount_data[[1]],Child_care_amount = Child_care_amount_data[[1]],
                       Funeral_industry_amount = Funeral_industry_amount_data[[1]],Supermarket_amount = Supermarket_amount_data[[1]],hospital_amount = hospital_amount_data[[1]],
                       Hypermarkets_amount = Hypermarkets_amount_data[[1]],Store_amount = Store_amount_data[[1]],Tutoring_amount = Tutoring_amount_data[[1]],clinic_amount = clinic_amount_data[[1]])
    
    data$area <- factor(data$area, levels = levels(Taipei_house$area))
    data$area <- factor(as.numeric(as.factor(data$area)), levels(house2_taipei$area))
    data$building_type <- factor(data$building_type, levels = levels(house2_taipei$building_type))
    data$Management_organization <- factor(data$Management_organization, levels = levels(house2_taipei$Management_organization))
    data$use_separation <- factor(data$use_separation, levels = levels(house2_taipei$use_separation))
    data$main_use <- factor(data$main_use, levels = levels(house2_taipei$main_use))
    data$building_materials <- factor(data$building_materials, levels = levels(house2_taipei$building_materials))
    data$rooms <- as.numeric(data$rooms)
    data$halls <- as.numeric(data$halls)
    data$bathrooms <- as.numeric(data$rooms)
    
    prediction_tai <- predict(house.rf_taipei, data[,c(1:45)])
    prediction_tai <- round(prediction_tai, 2)
    
    confi_low <- round(prediction_tai-taipei_sd[taipei_sd$area == area,2], 2)
    confi_high <- round(prediction_tai+taipei_sd[taipei_sd$area == area,2], 2)
    
    dist_facility_data <- rbind(Bus_Stop_dist = Bus_Stop_dist_data[[2]],Car_park_dist = Car_park_dist_data[[2]],GAS_dist = GAS_dist_data[[2]],
                                High_School_dist = High_School_dist_data[[2]],Incinerator_dist = Incinerator_dist_data[[2]],Library_dist = Library_dist_data[[2]],
                                MRT_dist = MRT_dist_data[[2]],Nursery_dist = Nursery_dist_data[[2]],Park_dist = Park_dist_data[[2]],Primary_dist = Primary_dist_data[[2]],
                                Secondary_School_dist = Secondary_School_dist_data[[2]],Temp_dist = Temp_dist_data[[2]],University_dist = University_dist_data[[2]],
                                Wastewater_dist = Wastewater_dist_data[[2]],Elderly_dist = Elderly_dist_data[[2]],Department_dist = Department_dist_data[[2]],
                                Physical_dist = Physical_dist_data[[2]],Fire_dist = Fire_dist_data[[2]],District_dist = District_dist_data[[2]],Cinema_dist = Cinema_dist_data[[2]],
                                Police_dist = Police_dist_data[[2]],markets_dist = markets_dist_data[[2]],Child_care_dist = Child_care_dist_data[[2]],Funeral_industry_dist = Funeral_industry_dist_data[[2]],
                                Supermarket_dist = Supermarket_dist_data[[2]],hospital_dist = hospital_dist_data[[2]],Hypermarkets_dist = Hypermarkets_dist_data[[2]],Store_dist = Store_dist_data[[2]],
                                Tutoring_dist = Tutoring_dist_data[[2]],clinic_dist = clinic_dist_data[[2]])
    
    amount_facility_data <- rbind(Bus_Stop_amount = Bus_Stop_amount_data[[2]],Car_park_amount = Car_park_amount_data[[2]],GAS_amount = GAS_amount_data[[2]],High_School_amount = High_School_amount_data[[2]],
                                  Incinerator_amount = Incinerator_amount_data[[2]],Library_amount = Library_amount_data[[2]],MRT_amount = MRT_amount_data[[2]],Nursery_amount = Nursery_amount_data[[2]],Park_amount = Park_amount_data[[2]],
                                  Primary_amount = Primary_amount_data[[2]],Secondary_School_amount = Secondary_School_amount_data[[2]],Temp_amount = Temp_amount_data[[2]],University_amount = University_amount_data[[2]],
                                  Wastewater_amount = Wastewater_amount_data[[2]],Elderly_amount = Elderly_amount_data[[2]],Department_amount = Department_amount_data[[2]],Physical_amount = Physical_amount_data[[2]],Fire_amount = Fire_amount_data[[2]],
                                  District_amount = District_amount_data[[2]],Cinema_amount = Cinema_amount_data[[2]],Police_amount = Police_amount_data[[2]],markets_amount = markets_amount_data[[2]],Child_care_amount = Child_care_amount_data[[2]],
                                  Funeral_industry_amount = Funeral_industry_amount_data[[2]],Supermarket_amount = Supermarket_amount_data[[2]],hospital_amount = hospital_amount_data[[2]],Hypermarkets_amount = Hypermarkets_amount_data[[2]],
                                  Store_amount = Store_amount_data[[2]],Tutoring_amount = Tutoring_amount_data[[2]],clinic_amount = clinic_amount_data[[2]])
    
    final <- list(data, prediction_tai, confi_low, confi_high, dist_facility_data, amount_facility_data, addr)
    return(final)
  })
  
  output$taipei_mymap <- renderLeaflet({
    if(input$taipei_predic[1] == 0){
      leaflet() %>%
        addProviderTiles("OpenStreetMap.DE") %>% 
        setView(121.53, 25.03,13) %>%    #顯示一開始定位用的
        addTiles()%>%
        #以下程式碼是把東西放到地圖用的
        addMarkers(~Longitude,~Latitude,popup = ~name,group="停車場",icon=carpark,data=Car_park,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="托嬰中心",icon=child,data=Child_care_center) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="電影院",icon=cinem,data=Cinema) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="診所",icon=clin,data=clinic,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="百貨公司",icon=depart,data=Department_store) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="區公所",icon=office,data=District_Office) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="老人安養機構",icon=elderly,data=Elderly_care) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="消防隊",icon=fire,data=Fire_brigade) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="殯葬資料",icon=funeral,data=Funeral_industry) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="加油站",icon=gas,data=GAS) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="高中",icon=school,data=High_School) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="醫院",icon=hospi,data=hospital) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="量販店",icon=hyper,data=Hypermarkets) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="焚化爐",icon=inciner,data=Incinerator) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="圖書館",icon=library,data=Library) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="捷運站",icon=mrt,data=MRT) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="幼兒園",icon=nurser,data=Nursery,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="公園",icon=par,data=Park,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="身心障礙福利機構",icon=phy,data=Physical_and_mental_mechanism) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="警察局",icon=police,data=Police_station) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="國小",icon=school,data=Primary_school) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="國中",icon=school,data=Secondary_School) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="便利商店",icon=stor,data=Store,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="超市",icon=super,data=Supermarket) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="寺廟",icon=temple,data=Temp,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="傳統市場",icon=tradition,data=Traditional_markets) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="補習班",icon=tutor,data=Tutoring,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="大學",icon=university,data=University) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="汙水處理廠",icon=waste,data=Wastewater) %>%
        addLayersControl(
          baseGroups=c("停車場", "托嬰中心", "電影院", "診所", "百貨公司", "區公所", "老人安養機構", "消防隊", 
                       "殯葬資料", "加油站", "高中", "醫院", "量販店", "焚化爐", "圖書館",  "捷運站", "幼兒園",
                       "公園", "身心障礙福利機構", "警察局", "國小", "國中", "便利商店", "超市", "寺廟", "傳統市場",
                       "補習班", "大學", "汙水處理廠"),
          option=layersControlOptions(collapsed=TRUE))
      #上面整段是放地圖右上方的勾選單
    } else{
      a <- pred_house_price()
      addr <- get_locat(a[[7]])
      x <- pred_house_price()
      
      leaflet() %>%
        addProviderTiles("OpenStreetMap.DE") %>%
        setView(addr[1], addr[2],zoom = 15) %>% 
        addTiles() %>% 
        addMarkers(~Longitude,~Latitude,popup = ~name,group="停車場",icon=carpark,data=Car_park,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="托嬰中心",icon=child,data=Child_care_center,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="電影院",icon=cinem,data=Cinema,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="診所",icon=clin,data=clinic,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="百貨公司",icon=depart,data=Department_store,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="區公所",icon=office,data=District_Office,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="老人安養機構",icon=elderly,data=Elderly_care,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="消防隊",icon=fire,data=Fire_brigade,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="殯葬資料",icon=funeral,data=Funeral_industry,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="加油站",icon=gas,data=GAS,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="高中",icon=school,data=High_School,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="醫院",icon=hospi,data=hospital,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="量販店",icon=hyper,data=Hypermarkets,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="焚化爐",icon=inciner,data=Incinerator,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="圖書館",icon=library,data=Library,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="捷運站",icon=mrt,data=MRT,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="幼兒園",icon=nurser,data=Nursery,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="公園",icon=par,data=Park,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="身心障礙福利機構",icon=phy,data=Physical_and_mental_mechanism,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="警察局",icon=police,data=Police_station,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="國小",icon=school,data=Primary_school,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="國中",icon=school,data=Secondary_School,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="便利商店",icon=stor,data=Store,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="超市",icon=super,data=Supermarket,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="寺廟",icon=temple,data=Temp,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="傳統市場",icon=tradition,data=Traditional_markets,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="補習班",icon=tutor,data=Tutoring,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="大學",icon=university,data=University,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="汙水處理廠",icon=waste,data=Wastewater,clusterOptions = markerClusterOptions()) %>%
        addLayersControl(
          baseGroups=c("停車場", "托嬰中心", "電影院", "診所", "百貨公司", "區公所", "老人安養機構", "消防隊", 
                       "殯葬資料", "加油站", "高中", "醫院", "量販店", "焚化爐", "圖書館",  "捷運站", "幼兒園",
                       "公園", "身心障礙福利機構", "警察局", "國小", "國中", "便利商店", "超市", "寺廟", "傳統市場",
                       "補習班", "大學", "汙水處理廠"),
          option=layersControlOptions(collapsed=FALSE))%>%
        addMarkers(addr[1],addr[2],popup = paste0(a[[7]],"\n每坪單價：",x[[2]]))
    }
  })
  
  #輸出台北房價結果
  output$out1<-renderText({
    if (is.null(pred_house_price())) {
      return(NULL)
    }
    x <- pred_house_price()[[2]]
    xx <- paste0("每坪價格為：", x)
  })
  
  #輸出台北房價信賴區間
  output$out2<-renderText({
    if (is.null(pred_house_price())) {
      return(NULL)
    }
    low <- pred_house_price()[[3]]
    high <- pred_house_price()[[4]]
    xx <- paste0("每坪價格信賴區間為：[", low, ",", high, "]")
  })
  
  #輸出台北物件附近距離圖
  output$dist_plot_taipei <- renderPlotly({
    data <- pred_house_price()[[1]]
    dist_new <- data[,c(15:44)]
    dist_num <- t(dist_new)
    dist_name <- c("Bus_Stop","Car_park","GAS","High_School","Incinerator","Library","MRT","Nursery",
                   "Park","Primary","Secondary_School","Temp","University","Wastewater","Elderly",
                   "Department","Physical","Fire","District","Cinema","Police","markets","Child_care",
                   "Funeral_industry","Supermarket","hospital","Hypermarkets","Store","Tutoring","clinic")
    dist_data <- data.frame(name = dist_name, d = dist_num)
    colnames(dist_data) = c("name2", "dist")
    leve <- dist_data[order(dist_data$dist, decreasing = TRUE),1]
    dist_data$name <- factor(dist_data$name2, levels = leve)
    #dist$name2 <- reorder(dist$name, dist$dist)
    
    ##bar chart
    d <- plot_ly(data = dist_data, x = ~dist, y = ~name, color = ~name, type = "bar", orientation = 'h')
    d
  })
  
  #輸出台北最近距離設施資料
  output$dist_data_taipei<-renderDataTable({
    if (is.null(pred_house_price())) {
      return(NULL)
    }
    dist_facility_data <- pred_house_price()[[5]]
  })
  
  #輸出台北物件附近數量圖
  output$amount_plot_taipei <- renderPlotly({
    data <- pred_house_price()[[1]]
    amount_new <- data[,c(46:75)]
    amount_num <- t(amount_new)
    amount_name <- c("Bus_Stop","Car_park","GAS","High_School","Incinerator","Library","MRT","Nursery",
                     "Park","Primary","Secondary_School","Temp","University","Wastewater","Elderly",
                     "Department","Physical","Fire","District","Cinema","Police","markets","Child_care",
                     "Funeral_industry","Supermarket","hospital","Hypermarkets","Store","Tutoring","clinic")
    amount_data <- data.frame(name = amount_name, a = amount_num)
    colnames(amount_data) = c("name2", "amount")
    leve <- amount_data[order(amount_data$amount, decreasing = TRUE),1]
    amount_data$name <- factor(amount_data$name2, levels = leve)
    amount_data_fin <- amount_data[amount_data$amount != 0,]
    ##bar chart
    d <- plot_ly(data = amount_data_fin, x = ~name, y = ~amount, color = ~name, type = "bar")
    d
  })
  
  #輸出台北500公尺內設施資料
  output$amount_data_taipei<-renderDataTable({
    if (is.null(pred_house_price())) {
      return(NULL)
    }
    amount_facility_data <- pred_house_price()[[6]]
  })
  
  #台北物件所在行政區每類住宅的高中低房價比例
  output$class_count_taipei <- renderPlotly({
    taipei <- Taipei_house
    IQR_taipei <- fivenum(taipei$unit_price)
    low_price_count <- data.frame(table(taipei[taipei$unit_price < IQR_taipei[2],2]), town = "台北市")
    medium_price_count <- data.frame(table(taipei[taipei$unit_price >= IQR_taipei[2] & taipei$unit_price <= IQR_taipei[4],2]), town = "台北市")
    high_price_count <- data.frame(table(taipei[taipei$unit_price > IQR_taipei[4],2]), town = "台北市")
    class_data <- cbind(low_price_count, medium_price_count, high_price_count)
    class_data <- class_data[,-c(3,4,6,7)]
    colnames(class_data) <- c("Area", "Low", "Medium", "High", "Town")
    
    p <- plot_ly(class_data, x = ~Area, y = ~Low, type = 'bar', name = 'Low') %>%
      add_trace(y = ~Medium, name = 'Medium') %>%
      add_trace(y = ~High, name = 'High') %>%
      layout(yaxis = list(title = 'Count'), barmode = 'stack')
    p
  })
  
  #台北實價登錄近兩年每個行政區價格之折線圖
  output$price_lines_taipei <- renderPlotly({
    taipei <- Taipei_house
    taipei_mean_price <- aggregate(taipei$unit_price, list(taipei$trading_date, taipei$area),  mean)
    taipei_mean_price <- data.frame(Date = taipei_mean_price[,1], Area = taipei_mean_price[,2], Mean_Price = taipei_mean_price[,3])
    taipei_mean_price$Date <- as.Date(taipei_mean_price$Date)
    taipei_mean_price <- taipei_mean_price[order(taipei_mean_price$Date, decreasing = FALSE),]
    
    p <- plot_ly(source = "source") %>% add_lines(data = taipei_mean_price, x = ~Date, y = ~Mean_Price, color = ~Area, mode = "lines")
    p
  })
  
  
  #預測新北房價
  pred_house_price_new <- eventReactive(input$new_predic,{
    addr2 <- paste0("新北市", input$new_area, input$new_Address)
    locat1 <- get_locat(addr2)
    Bus_Stop_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Bus_stop)
    Car_park_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Car_park)
    Child_care_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Child_care_center)
    Cinema_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Cinema)
    clinic_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], clinic)
    Department_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Department_store)
    District_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], District_Office)
    Elderly_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Elderly_care)
    Fire_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Fire_brigade)
    Funeral_industry_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Funeral_industry)
    GAS_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], GAS)
    High_School_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], High_School)
    hospital_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], hospital)
    Hypermarkets_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Hypermarkets)
    Incinerator_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Incinerator)
    Library_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Library)
    MRT_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], MRT)
    Nursery_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Nursery)
    Park_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Park)
    Physical_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Physical_and_mental_mechanism)
    Police_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Police_station)
    Primary_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Primary_school)
    Secondary_School_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Secondary_School)
    Store_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Store)
    Supermarket_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Supermarket)
    Temp_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Temp)
    markets_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Traditional_markets)
    Tutoring_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Tutoring)
    University_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], University)
    Wastewater_dist_data <- get_min_dist("新北市", input$new_area, locat1[1], locat1[2], Wastewater)
    
    Bus_Stop_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Bus_stop)
    Car_park_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Car_park)
    Child_care_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Child_care_center)
    Cinema_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Cinema)
    clinic_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], clinic)
    Department_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Department_store)
    District_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], District_Office)
    Elderly_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Elderly_care)
    Fire_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Fire_brigade)
    Funeral_industry_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Funeral_industry)
    GAS_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], GAS)
    High_School_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], High_School)
    hospital_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], hospital)
    Hypermarkets_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Hypermarkets)
    Incinerator_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Incinerator)
    Library_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Library)
    MRT_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], MRT)
    Nursery_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Nursery)
    Park_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Park)
    Physical_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Physical_and_mental_mechanism)
    Police_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Police_station)
    Primary_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Primary_school)
    Secondary_School_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Secondary_School)
    Store_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Store)
    Supermarket_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Supermarket)
    Temp_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Temp)
    markets_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Traditional_markets)
    Tutoring_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Tutoring)
    University_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], University)
    Wastewater_amount_data <- get_500_amout("新北市", input$new_area, locat1[1], locat1[2], Wastewater)
    
    CCP <- get_CCP(input$new_village, input$new_area, new_CCP)
    
    area <- input$new_area
    building_type <- input$new_building_type
    Management_organization <- input$new_Management_organization
    use_separation <- input$new_use_separation
    main_use <- input$new_main_use
    building_materials <- input$new_building_materials
    land_transfer <- input$new_land_transfer
    building_transfer <- input$new_building_transfer
    floor_transfer <- input$new_floor_transfer
    total_floor <- input$new_total_floor
    rooms <- input$new_rooms
    halls <- input$new_halls
    bathrooms <- input$new_bathrooms
    house_age <- input$new_house_age
    
    data1 <- data.frame(area,land_transfer,building_type,Management_organization,building_transfer,use_separation,floor_transfer,total_floor,main_use,
                        building_materials,rooms,halls,bathrooms,house_age,Bus_Stop_dist = Bus_Stop_dist_data[[1]],Car_park_dist = Car_park_dist_data[[1]],
                        GAS_dist = GAS_dist_data[[1]],High_School_dist = High_School_dist_data[[1]],Incinerator_dist = Incinerator_dist_data[[1]],Library_dist = Library_dist_data[[1]],
                        MRT_dist = MRT_dist_data[[1]],Nursery_dist = Nursery_dist_data[[1]],Park_dist = Park_dist_data[[1]],Primary_dist = Primary_dist_data[[1]],
                        Secondary_School_dist = Secondary_School_dist_data[[1]],Temp_dist = Temp_dist_data[[1]],University_dist = University_dist_data[[1]],
                        Wastewater_dist = Wastewater_dist_data[[1]],Elderly_dist = Elderly_dist_data[[1]],Department_dist = Department_dist_data[[1]],Physical_dist = Physical_dist_data[[1]],
                        Fire_dist = Fire_dist_data[[1]],District_dist = District_dist_data[[1]],Cinema_dist = Cinema_dist_data[[1]],Police_dist = Police_dist_data[[1]],markets_dist = markets_dist_data[[1]],
                        Child_care_dist = Child_care_dist_data[[1]],Funeral_industry_dist = Funeral_industry_dist_data[[1]],Supermarket_dist = Supermarket_dist_data[[1]],
                        hospital_dist = hospital_dist_data[[1]],Hypermarkets_dist = Hypermarkets_dist_data[[1]],Store_dist = Store_dist_data[[1]],Tutoring_dist = Tutoring_dist_data[[1]],
                        clinic_dist = clinic_dist_data[[1]],CCP,Bus_Stop_amount = Bus_Stop_amount_data[[1]],Car_park_amount = Car_park_amount_data[[1]],GAS_amount = GAS_amount_data[[1]],
                        High_School_amount = High_School_amount_data[[1]],Incinerator_amount = Incinerator_amount_data[[1]],Library_amount = Library_amount_data[[1]],MRT_amount = MRT_amount_data[[1]],
                        Nursery_amount = Nursery_amount_data[[1]],Park_amount = Park_amount_data[[1]],Primary_amount = Primary_amount_data[[1]],Secondary_School_amount = Secondary_School_amount_data[[1]],
                        Temp_amount = Temp_amount_data[[1]],University_amount = University_amount_data[[1]],Wastewater_amount = Wastewater_amount_data[[1]],Elderly_amount = Elderly_amount_data[[1]],
                        Department_amount = Department_amount_data[[1]],Physical_amount = Physical_amount_data[[1]],Fire_amount = Fire_amount_data[[1]],District_amount = District_amount_data[[1]],
                        Cinema_amount = Cinema_amount_data[[1]],Police_amount = Police_amount_data[[1]],markets_amount = markets_amount_data[[1]],Child_care_amount = Child_care_amount_data[[1]],
                        Funeral_industry_amount = Funeral_industry_amount_data[[1]],Supermarket_amount = Supermarket_amount_data[[1]],hospital_amount = hospital_amount_data[[1]],
                        Hypermarkets_amount = Hypermarkets_amount_data[[1]],Store_amount = Store_amount_data[[1]],Tutoring_amount = Tutoring_amount_data[[1]],clinic_amount = clinic_amount_data[[1]])
    
    data1$area <- factor(data1$area, levels = levels(new_Taipei_house$area))
    data1$area <- factor(as.numeric(as.factor(data1$area)), levels = levels(house2_new$area))
    data1$building_type <- factor(data1$building_type, levels = levels(house2_new$building_type))
    data1$Management_organization <- factor(data1$Management_organization, levels = levels(house2_new$Management_organization))
    data1$use_separation <- factor(data1$use_separation, levels = levels(house2_new$use_separation))
    data1$main_use <- factor(data1$main_use, levels = levels(house2_new$main_use))
    data1$building_materials <- factor(data1$building_materials, levels = levels(house2_new$building_materials))
    data1$rooms <- as.numeric(data1$rooms)
    data1$halls <- as.numeric(data1$halls)
    data1$bathrooms <- as.numeric(data1$rooms)
    
    prediction_new <- predict(house.rf_new, data1[,c(1:45)])
    prediction_new <- round(prediction_new,2)
    
    confi_low_new <- round(prediction_new-new_sd[new_sd$area == area,2], 2)
    confi_high_new <- round(prediction_new+new_sd[new_sd$area == area,2], 2)
    
    dist_facility_data_new <- rbind(Bus_Stop_dist = Bus_Stop_dist_data[[2]],Car_park_dist = Car_park_dist_data[[2]],GAS_dist = GAS_dist_data[[2]],
                                    High_School_dist = High_School_dist_data[[2]],Incinerator_dist = Incinerator_dist_data[[2]],Library_dist = Library_dist_data[[2]],
                                    MRT_dist = MRT_dist_data[[2]],Nursery_dist = Nursery_dist_data[[2]],Park_dist = Park_dist_data[[2]],Primary_dist = Primary_dist_data[[2]],
                                    Secondary_School_dist = Secondary_School_dist_data[[2]],Temp_dist = Temp_dist_data[[2]],University_dist = University_dist_data[[2]],
                                    Wastewater_dist = Wastewater_dist_data[[2]],Elderly_dist = Elderly_dist_data[[2]],Department_dist = Department_dist_data[[2]],
                                    Physical_dist = Physical_dist_data[[2]],Fire_dist = Fire_dist_data[[2]],District_dist = District_dist_data[[2]],Cinema_dist = Cinema_dist_data[[2]],
                                    Police_dist = Police_dist_data[[2]],markets_dist = markets_dist_data[[2]],Child_care_dist = Child_care_dist_data[[2]],Funeral_industry_dist = Funeral_industry_dist_data[[2]],
                                    Supermarket_dist = Supermarket_dist_data[[2]],hospital_dist = hospital_dist_data[[2]],Hypermarkets_dist = Hypermarkets_dist_data[[2]],Store_dist = Store_dist_data[[2]],
                                    Tutoring_dist = Tutoring_dist_data[[2]],clinic_dist = clinic_dist_data[[2]])
    
    amount_facility_data_new <- rbind(Bus_Stop_amount = Bus_Stop_amount_data[[2]],Car_park_amount = Car_park_amount_data[[2]],GAS_amount = GAS_amount_data[[2]],High_School_amount = High_School_amount_data[[2]],
                                      Incinerator_amount = Incinerator_amount_data[[2]],Library_amount = Library_amount_data[[2]],MRT_amount = MRT_amount_data[[2]],Nursery_amount = Nursery_amount_data[[2]],Park_amount = Park_amount_data[[2]],
                                      Primary_amount = Primary_amount_data[[2]],Secondary_School_amount = Secondary_School_amount_data[[2]],Temp_amount = Temp_amount_data[[2]],University_amount = University_amount_data[[2]],
                                      Wastewater_amount = Wastewater_amount_data[[2]],Elderly_amount = Elderly_amount_data[[2]],Department_amount = Department_amount_data[[2]],Physical_amount = Physical_amount_data[[2]],Fire_amount = Fire_amount_data[[2]],
                                      District_amount = District_amount_data[[2]],Cinema_amount = Cinema_amount_data[[2]],Police_amount = Police_amount_data[[2]],markets_amount = markets_amount_data[[2]],Child_care_amount = Child_care_amount_data[[2]],
                                      Funeral_industry_amount = Funeral_industry_amount_data[[2]],Supermarket_amount = Supermarket_amount_data[[2]],hospital_amount = hospital_amount_data[[2]],Hypermarkets_amount = Hypermarkets_amount_data[[2]],
                                      Store_amount = Store_amount_data[[2]],Tutoring_amount = Tutoring_amount_data[[2]],clinic_amount = clinic_amount_data[[2]])
    
    final1 <- list(data1, prediction_new, confi_low_new, confi_high_new, dist_facility_data_new, amount_facility_data_new, addr2)
    return(final1)
  })
  
  output$new_mymap <- renderLeaflet({
    if(input$new_predic == 0){
      leaflet() %>%
        addProviderTiles("OpenStreetMap.DE") %>% 
        setView(121.53, 25.03,13) %>%    #顯示一開始定位用的
        addTiles()%>%
        #以下程式碼是把東西放到地圖用的
        addMarkers(~Longitude,~Latitude,popup = ~name,group="停車場",icon=carpark,data=Car_park,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="托嬰中心",icon=child,data=Child_care_center) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="電影院",icon=cinem,data=Cinema) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="診所",icon=clin,data=clinic,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="百貨公司",icon=depart,data=Department_store) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="區公所",icon=office,data=District_Office) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="老人安養機構",icon=elderly,data=Elderly_care) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="消防隊",icon=fire,data=Fire_brigade) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="殯葬資料",icon=funeral,data=Funeral_industry) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="加油站",icon=gas,data=GAS) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="高中",icon=school,data=High_School) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="醫院",icon=hospi,data=hospital) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="量販店",icon=hyper,data=Hypermarkets) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="焚化爐",icon=inciner,data=Incinerator) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="圖書館",icon=library,data=Library) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="捷運站",icon=mrt,data=MRT) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="幼兒園",icon=nurser,data=Nursery,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="公園",icon=par,data=Park,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="身心障礙福利機構",icon=phy,data=Physical_and_mental_mechanism) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="警察局",icon=police,data=Police_station) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="國小",icon=school,data=Primary_school) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="國中",icon=school,data=Secondary_School) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="便利商店",icon=stor,data=Store,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="超市",icon=super,data=Supermarket) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="寺廟",icon=temple,data=Temp,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="傳統市場",icon=tradition,data=Traditional_markets) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="補習班",icon=tutor,data=Tutoring,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="大學",icon=university,data=University) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="汙水處理廠",icon=waste,data=Wastewater) %>%
        addLayersControl(
          baseGroups=c("停車場", "托嬰中心", "電影院", "診所", "百貨公司", "區公所", "老人安養機構", "消防隊", 
                       "殯葬資料", "加油站", "高中", "醫院", "量販店", "焚化爐", "圖書館",  "捷運站", "幼兒園",
                       "公園", "身心障礙福利機構", "警察局", "國小", "國中", "便利商店", "超市", "寺廟", "傳統市場",
                       "補習班", "大學", "汙水處理廠"),
          option=layersControlOptions(collapsed=TRUE))
      #上面整段是放地圖右上方的勾選單
    }
    
    else{
      a <- pred_house_price_new()#此部分要特別注意，不能在這邊直接拉使用者輸入的物件，會導致eventReactive只執行一次，第二次開始會自動執行
      addr <- get_locat(a[[7]])
      x <- pred_house_price_new()
      
      leaflet() %>%
        addProviderTiles("OpenStreetMap.DE") %>%
        setView(addr[1], addr[2],zoom = 15) %>% 
        addTiles() %>% 
        addMarkers(~Longitude,~Latitude,popup = ~name,group="停車場",icon=carpark,data=Car_park,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="托嬰中心",icon=child,data=Child_care_center,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="電影院",icon=cinem,data=Cinema,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="診所",icon=clin,data=clinic,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="百貨公司",icon=depart,data=Department_store,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="區公所",icon=office,data=District_Office,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="老人安養機構",icon=elderly,data=Elderly_care,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="消防隊",icon=fire,data=Fire_brigade,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="殯葬資料",icon=funeral,data=Funeral_industry,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="加油站",icon=gas,data=GAS,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="高中",icon=school,data=High_School,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="醫院",icon=hospi,data=hospital,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="量販店",icon=hyper,data=Hypermarkets,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="焚化爐",icon=inciner,data=Incinerator,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="圖書館",icon=library,data=Library,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="捷運站",icon=mrt,data=MRT,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="幼兒園",icon=nurser,data=Nursery,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="公園",icon=par,data=Park,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="身心障礙福利機構",icon=phy,data=Physical_and_mental_mechanism,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="警察局",icon=police,data=Police_station,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="國小",icon=school,data=Primary_school,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="國中",icon=school,data=Secondary_School,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="便利商店",icon=stor,data=Store,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="超市",icon=super,data=Supermarket,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="寺廟",icon=temple,data=Temp,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="傳統市場",icon=tradition,data=Traditional_markets,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="補習班",icon=tutor,data=Tutoring,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="大學",icon=university,data=University,clusterOptions = markerClusterOptions()) %>%
        addMarkers(~Longitude,~Latitude,popup = ~name,group="汙水處理廠",icon=waste,data=Wastewater,clusterOptions = markerClusterOptions()) %>%
        addLayersControl(
          baseGroups=c("停車場", "托嬰中心", "電影院", "診所", "百貨公司", "區公所", "老人安養機構", "消防隊", 
                       "殯葬資料", "加油站", "高中", "醫院", "量販店", "焚化爐", "圖書館",  "捷運站", "幼兒園",
                       "公園", "身心障礙福利機構", "警察局", "國小", "國中", "便利商店", "超市", "寺廟", "傳統市場",
                       "補習班", "大學", "汙水處理廠"),
          option=layersControlOptions(collapsed=FALSE))%>%
        addMarkers(addr[1],addr[2],popup = paste0(a[[7]],"\n每坪單價：",x[[2]]))
    }
  })
  
  #輸出新北房價結果
  output$out3<-renderText({
    if (is.null(pred_house_price_new())) {
      return(NULL)
    }
    x <- pred_house_price_new()[[2]]
    xx <- paste0("每坪價格為：", x)
  })
  
  #輸出新北房價信賴區間
  output$out4<-renderText({
    if (is.null(pred_house_price_new())) {
      return(NULL)
    }
    low <- pred_house_price_new()[[3]]
    high <- pred_house_price_new()[[4]]
    xx <- paste0("每坪價格信賴區間為：[", low, ",", high, "]")
  })
  
  #輸出新北物件附近距離圖
  output$dist_plot_new <- renderPlotly({
    data <- pred_house_price_new()[[1]]
    dist_new <- data[,c(15:44)]
    dist_num <- t(dist_new)
    dist_name <- c("Bus_Stop","Car_park","GAS","High_School","Incinerator","Library","MRT","Nursery",
                   "Park","Primary","Secondary_School","Temp","University","Wastewater","Elderly",
                   "Department","Physical","Fire","District","Cinema","Police","markets","Child_care",
                   "Funeral_industry","Supermarket","hospital","Hypermarkets","Store","Tutoring","clinic")
    dist_data <- data.frame(name = dist_name, d = dist_num)
    colnames(dist_data) = c("name2", "dist")
    leve <- dist_data[order(dist_data$dist, decreasing = TRUE),1]
    dist_data$name <- factor(dist_data$name2, levels = leve)
    #dist$name2 <- reorder(dist$name, dist$dist)
    
    ##bar chart
    d <- plot_ly(data = dist_data, x = ~dist, y = ~name, color = ~name, type = "bar", orientation = 'h')
    d
  })
  
  #輸出新北最近距離設施資料
  output$dist_data_new<-renderDataTable({
    if (is.null(pred_house_price_new())) {
      return(NULL)
    }
    dist_facility_data_new <- pred_house_price_new()[[5]]
  })
  
  #輸出新北物件附近數量圖
  output$amount_plot_new <- renderPlotly({
    data <- pred_house_price_new()[[1]]
    amount_new <- data[,c(46:75)]
    amount_num <- t(amount_new)
    amount_name <- c("Bus_Stop","Car_park","GAS","High_School","Incinerator","Library","MRT","Nursery",
                     "Park","Primary","Secondary_School","Temp","University","Wastewater","Elderly",
                     "Department","Physical","Fire","District","Cinema","Police","markets","Child_care",
                     "Funeral_industry","Supermarket","hospital","Hypermarkets","Store","Tutoring","clinic")
    amount_data <- data.frame(name = amount_name, a = amount_num)
    colnames(amount_data) = c("name2", "amount")
    leve <- amount_data[order(amount_data$amount, decreasing = TRUE),1]
    amount_data$name <- factor(amount_data$name2, levels = leve)
    amount_data_fin <- amount_data[amount_data$amount != 0,]
    ##bar chart
    d <- plot_ly(data = amount_data_fin, x = ~name, y = ~amount, color = ~name, type = "bar")
    d
  })
  
  #輸出新北最近距離設施資料
  output$amount_data_new<-renderDataTable({
    if (is.null(pred_house_price_new())) {
      return(NULL)
    }
    amount_facility_data_new <- pred_house_price_new()[[6]]
  })
  
  #新北物件所在行政區每類住宅的高中低房價比例
  output$class_count_new <- renderPlotly({
    new_taipei <- new_Taipei_house
    IQR_new <- fivenum(new_taipei$unit_price)
    low_price_count_new <- data.frame(table(new_taipei[new_taipei$unit_price < IQR_new[2],2]), town = "新北市")
    medium_price_count_new <- data.frame(table(new_taipei[new_taipei$unit_price >= IQR_new[2] & new_taipei$unit_price <= IQR_new[4],2]), town = "新北市")
    high_price_count_new <- data.frame(table(new_taipei[new_taipei$unit_price > IQR_new[4],2]), town = "新北市")
    class_data_new <- cbind(low_price_count_new, medium_price_count_new, high_price_count_new)
    class_data_new <- class_data_new[,-c(3,4,6,7)]
    colnames(class_data_new) <- c("Area", "Low", "Medium", "High", "Town")
    
    p <- plot_ly(class_data_new, x = ~Area, y = ~Low, type = 'bar', name = 'Low') %>%
      add_trace(y = ~Medium, name = 'Medium') %>%
      add_trace(y = ~High, name = 'High') %>%
      layout(yaxis = list(title = 'Count'), barmode = 'stack')
    p
  })
  
  #新北實價登錄近兩年每個行政區價格之折線圖
  output$price_lines_new <- renderPlotly({
    new_taipei <- new_Taipei_house
    new_taipei_mean_price <- aggregate(new_taipei$unit_price, list(new_taipei$trading_date, new_taipei$area),  mean)
    new_taipei_mean_price <- data.frame(Date = new_taipei_mean_price[,1], Area = new_taipei_mean_price[,2], Mean_Price = new_taipei_mean_price[,3])
    new_taipei_mean_price$Date <- as.Date(new_taipei_mean_price$Date)
    new_taipei_mean_price <- new_taipei_mean_price[order(new_taipei_mean_price$Date, decreasing = FALSE),]
    
    p <- plot_ly(source = "source") %>% add_lines(data = new_taipei_mean_price, x = ~Date, y = ~Mean_Price, color = ~Area, mode = "lines")
    p
  })
  
  #爬永慶房屋資料
  Crawl <- eventReactive(input$in2_spider, {
    house_data <- get_yungching_web(input$town_spider, input$area_spider, input$street_spider, input$page)
  })
  
  output$out2_spider<-renderDataTable({
    if (is.null(Crawl())) {
      return(NULL)
    }
    house_crawl <- Crawl()
    
  })
  
})