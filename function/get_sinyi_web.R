get_sinyi_web <- function(town, area_number, street_spider, page){
  # town <- "Taichung"
  # area_number <- "420"
  # street_spider <- "豐原大道"
  # 街道利用函數轉換文字，將中文轉成網頁可以識別的UTF-8編碼
  street_spider <- iconv(street_spider, from='UTF-8', to='UTF-8')
  street <- URLencode(street_spider)
  # 信義房屋的關鍵字搜尋，縣市別要以英文帶入
  url <- paste0("https://www.sinyi.com.tw/buy/list/", street, "-keyword/", town, "-city/", area_number, "-zip/", 'Taipei-R-mrtline/03-mrt/default-desc/', page)
  # url <- paste0("https://www.sinyi.com.tw/buy/list/%E8%B1%90%E5%8E%9F%E5%A4%A7%E9%81%93-keyword/Taichung-city/420-zip/Taipei-R-mrtline/03-mrt/default-desc/1")
  comment <- read_html(url)
  web <- comment %>% html_nodes('.buy-list-item a') %>% xml_attr("href")
  # 只取出有包含"breadcrumb=list"物件網址，沒有包含的都是推薦物件
  web <- web[str_detect(web, pattern = "breadcrumb=list", negate = FALSE)]
  web <- paste0("https://www.sinyi.com.tw/",web)
  house_web <- paste0('<a href="',web,'">',web,'</a>')
  # 取得物件的標題
  house_title <- comment %>% html_nodes('.LongInfoCard_TypeWeb .LongInfoCard_Type_Name') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  # 取得物件的價格，但價格沒有一個class可以做精準位置的抓取，所以就抓有包含加入最愛字段的資料
  house_price <- comment %>% html_nodes('.LongInfoCard_Type_Right') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  house_price <- house_price %>% gsub("加入最愛", "", .)
  house_type1 <- comment %>% html_nodes('.LongInfoCard_TypeWeb .LongInfoCard_Type_Address span') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  house_type2 <- comment %>% html_nodes('.LongInfoCard_TypeWeb .LongInfoCard_Type_HouseInfo span') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  # 取出物件的其他相關資料
  adress <- house_type1[seq(1, length(house_type1),by = 3)]
  House_age <- house_type1[seq(2, length(house_type1),by = 3)]
  Type <- house_type1[seq(3, length(house_type1),by = 3)]
  Square_feet_type <- house_type[seq(1, length(house_type2),by = 4)]
  Building_square_feet <- house_type2[seq(2, length(house_type2),by = 4)]
  House_pattern <- house_type2[seq(3, length(house_type2),by = 4)]
  Floor <- house_type2[seq(4, length(house_type2),by = 4)]
  # 計算每坪的價格
  p <- sub(",", "", house_price)
  p <- sub("萬", "", p)
  p <- sub("\\(含車位價\\)", "", p)
  p <- as.numeric(p)
  m <- sub("建坪 ", "", Square_feet_type)
  m <- sub("地坪 ", "", m)
  m <- as.numeric(m)
  unit_Price <- paste0(round(p/m,2), "萬")
  
  house_data <- data.frame(Title, unit_Price = unit_Price, Price = house_price, Type, House_age, Floor, Square_feet_type, Building_square_feet, House_pattern, Web = house_web)
  house_data_web <- datatable(house_data, escape = FALSE)
}
