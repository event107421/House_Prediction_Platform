get_yungching_web <- function(town_spider, area_spider, street_spider, page) {
  # 手動轉換文字，將中文轉成網頁可以識別的UTF-8編碼
  # x_a <- as.character(charToRaw(town_spider))
  # temp <- ""
  # for (i in 1:length(x_a)) {
  #   temp <- paste0(temp,'%',x_a[i])
  # }
  # x_a <- as.character(temp)
  # 
  # x_b <- as.character(charToRaw(area_spider))
  # temp2 <- ""
  # for (i in 1:length(x_b)) {
  #   temp2 <- paste0(temp2,'%',x_b[i])
  # }
  # x_b <- as.character(temp2)
  # 利用函數轉換文字，將中文轉成網頁可以識別的UTF-8編碼
  # 縣市別
  town_spider <- iconv(town_spider, from='UTF-8', to='UTF-8')
  x_a <- URLencode(town_spider)
  # 區域別
  area_spider <- iconv(area_spider, from='UTF-8', to='UTF-8')
  x_b <- URLencode(area_spider)
  x <- paste0(x_a,'-',x_b) 
  # 街道
  street_spider <- iconv(street_spider, from='UTF-8', to='UTF-8')
  street <- URLencode(street_spider)
  url <- paste0('http://buy.yungching.com.tw/region/%E4%BD%8F%E5%AE%85_p/', x,'_c/_rm/?kw=', street, '&pg=', page)
  comment <- read_html(url)
  # uastring <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36"
  # session <- html_session(url, user_agent(uastring))
  # 判斷使用者是否有輸入頁數
  if (as.integer(page) > 0) {
    page_start <- 1
    page_end <- page
  } else {
    page_start <- 1
    # 取得以關鍵字搜尋的物件總頁數
    page_list <- comment %>% html_nodes('.m-pagination-bd li') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
    # 取得倒數第三個值，為最後一頁的頁數
    page_end <- page_list[length(page_list) - 2]
  }

  # 取得每個物件的網址
  web <- comment %>% html_nodes('.item-info a') %>% html_attr("href") %>% iconv(from="UTF-8", to="UTF-8")
  house_web <- paste0('http://buy.yungching.com.tw', web)
  # 加上href屬性，到時給data.table套件識別為網址
  house_web_new <- paste0('<a href="',house_web,'">',house_web,'</a>')
  # 取得每個物件的名字
  house_title <- comment %>% html_nodes('.item-info a') %>% html_attr("title") %>% iconv(from="UTF-8", to="UTF-8")
  # 取得每個物件的價格
  house_price <- comment %>% html_nodes('.price') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  # 取得每個物件的其他附屬資料
  house_type <- comment %>% html_nodes('.item-info ul') %>% html_text() %>% iconv(from="UTF-8", to="UTF-8")
  # 因house_type中是利用\r\n符號切割欄位，所以這邊利用\r\n符號分割
  type <- strsplit(house_type,"\r\n")
  house_data <- data.frame(t(data.frame(type)), row.names = c(1:length(house_title)))
  house_data <- house_data[,c(-2,-4,-9,-11,-13,-15)]
  colnames(house_data) <- c("Type", "House_age", "Floor", "Land_square_feet", 
                            "Square_feet_type", "Building_square_feet",
                            "House_pattern", "Add", "Parking")
  # 資料清理
  p <- sub(" ", "", house_price)
  p <- sub(",", "", p)
  p <- sub("萬", "", p)
  p <- as.numeric(p)
  m <- sub(" ", "", house_data$Building_square_feet)
  m <- sub("坪", "", m)
  m <- sub("建物", "", m)
  m <- as.numeric(m)
  unit_Price <- paste0(round(p/m,2), "萬")
  # 將上面爬取整理好的資料整併成一個dataframe
  house_data_new <- data.frame(Name = house_title, unit_Price = unit_Price, Price = house_price, house_data, Web = house_web_new)
  # 利用data.table套件將資料轉成網頁可識別的形式
  house_data_web <- datatable(house_data_new, escape = FALSE)
  return(house_data_web)
}