get_nra_web <- function(town_number, area_number, pages){
  # 街道利用函數轉換文字，將中文轉成網頁可以識別的UTF-8編碼
  street_spider <- iconv(street_spider, from='UTF-8', to='UTF-8')
  street <- URLencode(street_spider)
  # 台北市city編號為1，新北市編號為3
  url <- paste0("http://www.nra.com.tw/buying/bsearch.php?page=", pages,"&search_ajax=1&search_type=&keyword=", street, "&mrts=&thsr=&school=&school_item=&town=", area_number, "&city=", town_number, "&house_use=&house_type=&area_size_s=0&area_size_l=999999&money_s=0&money_l=999999&parking=&s_room=&l_room=&sort_type=detail_day%20DESC")
  # url <- paste0("https://www.nra.com.tw/buying/bsearch.php?page=2&search_ajax=1&search_type=1&keyword=%E8%B1%90%E5%8E%9F%E5%A4%A7%E9%81%93&mrts=&thsr=&school=&school_item=&town=420&town_s=&city=&house_use=&house_type=&area_size_s=&area_size_l=&money_s=&money_l=&s_room=&l_room=&floornum=&s_floor=&l_floor=&parking=&direction=&roomAge=&s_age=&l_age=&sort_type=detail_day%20DESC")

  comment <- read_html(url)
  # 取得每個物件的網址
  web <- comment %>% html_nodes('.obj_details.col-sm-8 a') %>% html_attr("href") %>% iconv(from="UTF-8", to="UTF-8")
  web <- web[-c(1:28)]
  web <- paste0('http://www.nra.com.tw/buying/',web)
  house_web <- paste0('<a href="',web,'">',web,'</a>')
  house_title <- comment %>% html_nodes('.limited_text') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  house_price <- comment %>% html_nodes('.price_n span') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  house_type1 <- comment %>% html_nodes('.status2 span') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  house_type2 <- comment %>% html_nodes('.status3 span') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  house_type3 <- comment %>% html_nodes('.status4 span') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  # 進行爬取後的資料選取，因為可能會有一個欄位拆成多個欄位的情形，要再將其合併
  Title <- paste0(house_title[seq(1, 28, by = 3)], house_title[seq(2, 29, by = 3)])
  Price <- paste0(house_price[seq(1, 19, by = 2)], house_price[seq(2, 20, by = 2)])
  Type <- house_type1[seq(1,28,by = 3)]
  House_age <- house_type1[seq(2,29,by = 3)]
  Floor <- house_type1[seq(3,30,by = 3)]
  Land_square_feet <- house_type2[seq(2,29,by = 3)]
  Building_square_feet <- house_type2[seq(3,30,by = 3)]
  House_pattern <- house_type2[seq(1,28,by = 3)]
  Parking <- paste0(house_type3[seq(1, 19, by = 2)], house_type3[seq(2, 20, by = 2)])
  # 進行爬取後的資料清理
  p <- sub(",", "", Price)
  p <- sub("萬", "", p)
  p <- as.numeric(p)
  m <- sub("坪", "", Building_square_feet)
  m <- sub("建物", "", m)
  m <- as.numeric(m)
  unit_Price <- paste0(round(p/m,2), "萬")
  
  house_data <- data.frame(Title, unit_Price = unit_Price, Price, Type, House_age, Floor, Land_square_feet, Building_square_feet, House_pattern, Parking, Web = house_web)
  house_data_web <- datatable(house_data, escape = FALSE)
}
