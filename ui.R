# install.packages(c("leaflet", "shiny", "shinydashboard", 
#                    "ggplot2", "RCurl", "rjson", "Imap", 
#                    "rvest", "httr", "DT", "randomForest", 
#                    "plotly", "ggplot2"))

library(leaflet)
library(shiny)
library(shinydashboard)
library(ggplot2) 
library(RCurl)
library(rjson)
library(Imap)
library(rvest)
library(httr)
library(DT)
library(randomForest)
library(plotly)
library(ggplot2)

dashboardPage(
  skin = "purple",
  #標題
  dashboardHeader(title = "House Price"
  ),
  #左欄
  dashboardSidebar(
    sidebarMenu(
      sidebarMenu(h3("Introduction",style = "color:White;font-family: '微軟正黑體'"),
                 menuItem("介紹", tabName = "home", icon = icon("spinner"))
      ),
      sidebarMenu(h3("Map & Prediction",style = "color:White;font-family: '微軟正黑體'"),
                 menuItem("台北市預測房價地圖", tabName = "taipei_price", icon = icon("balance-scale")),
                 menuItem("新北市預測房價地圖", tabName = "new_price", icon = icon("balance-scale"))
      ),
      sidebarMenu(h3("House Information",style = "color:White;font-family: '微軟正黑體'"),
                 menuItem("台北市標的物資訊", tabName = "taipei_information", icon = icon("dashboard", verify_fa = FALSE)),
                 menuItem("新北市標的物資訊", tabName = "new_information", icon = icon("dashboard", verify_fa = FALSE))
      ),
      sidebarMenu(h3("Web",style = "color:White;font-family: '微軟正黑體'"),
                 menuItem("永慶房屋近期販售房屋物件查詢", tabName = "spider", icon = icon("file-text", verify_fa = FALSE))
      ),
      sidebarMenuOutput("menu"),
      menuItemOutput("menuitem")
    )
  ),
  #網頁內容，h1是指點選進去後所顯示的網頁標題
  dashboardBody(
    tabItems(
      tabItem(tabName = "home",
              fluidRow(
                
                box(
                  title = "Introduce",status = "warning",solidHeader = TRUE,
                  
                  h3("研究生:謝明穎",style = "font-family: '微軟正黑體'"), br(),
                  h3("指導教授:謝邦昌 博士",style = "font-family: '微軟正黑體'"), br(),
                  h3("指導教授:張光昭 博士",style = "font-family: '微軟正黑體'"), br(),
                  collapsible = TRUE,width =3
                )
                ,
                
                column(width =9,
                       box(
                         
                         title = "平台設立與功能簡介",status = "primary",solidHeader = TRUE,
                         h3('以往不動產估價必須依靠鑑價師，但是，不動產個別估價成本較高，以致於發展出大量估價法，利用大量的資料來推估每個不動產的價值。
                            本研究利用近兩年的',
                            span('實價登錄',style = "color:green;font-family: '微軟正黑體'"),
                            '資料結合',
                            span('政府開放平台環境設施',style = "color:green;font-family: '微軟正黑體'"),
                            '資料，以',
                            span('隨機森林',style = "color:green;font-family: '微軟正黑體'"),
                            '建置模型，並利用R-shiny來建立此平台，透過視覺化的呈現讓使用者能迅速了解房屋行情以及物件周圍環境狀況',style = "font-family: '微軟正黑體'"
                         ),
                         br(),
                         h4("本平台有三大功能，功能如下:",br(),br(),
                            span("Map & Prediction",style = "font-weight:bold;color:red;font-family: '微軟正黑體'"),br(),br(),
                            "此功能分為台北市及雙北市兩個頁面，使用者可以依照想估價的縣市進行選擇，當使用者輸入基本房屋特性後
                            ，即可進行估價，地圖上也會進行地址地位，使用者也可以選擇周圍要出現哪一類環境設施。",br(),br(),
                            span("House Information",style = "font-weight:bold;color:red;font-family: '微軟正黑體'"),br(),br(),
                            "此功能會依照使用者在第一個部分所輸入的地址進行定位後，算出至附近環境設施最短距離
                            ，以及算出500公尺內設施數量，此外，也將近兩年實價登錄資料一併進行視覺化圖表的呈現。",br(),br(),
                            span("Web",style = "font-weight:bold;color:red;font-family: '微軟正黑體'"),br(),br(),
                            "最後一個功能則是結合網路爬蟲技術，蒐集房仲業者網站近期所販賣之物件，以供使用者參考。",br(),br(),
                            style = "font-family: '微軟正黑體'")
                         ,br(),
                         tags$div(tags$a(href="http://www.stat.fju.edu.tw/", h4("輔仁大學管理學院統計資訊學系"))),
                         tags$div(tags$a(href="http://mgt.tmu.edu.tw/", h4("台北醫學大學管理學院"))),
                         tags$div(tags$a(href="http://www.cdms.org.tw/", h4("CDMS官網"))),
                         tags$div(tags$a(href="http://www.trend-go.com/", h4("全國達康股份有限公司"))),
                         width =NULL,
                         collapsible = TRUE
                       )
                )
              )
              ),
      
      tabItem(tabName = "taipei_price",
              h2("預測房價"),
              box(
                title = "請填入房屋屬性",status = "warning",solidHeader = TRUE,
                fluidRow(
                  column(8,""),
                  column(4,actionButton("taipei_predic", label = p("估價",span(style="color:red ; font-size:20px "),style=" font-family:Microsoft YaHei ; font-size:16px "),width = '100%'))
                ),
                
                fluidRow(
                  column(4,selectInput("area", label = p("區別(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('士林區',
                                                      '大同區',
                                                      '大安區',
                                                      '中山區',
                                                      '中正區',
                                                      '內湖區',
                                                      '文山區',
                                                      '北投區',
                                                      '松山區',
                                                      '信義區',
                                                      '南港區',
                                                      '萬華區'))),
                  column(4,textInput("village", label = p("村里(選填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "))),
                  column(4,textInput("Address", label = p("地址路段(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px ")))
                ),
                
                fluidRow(
                  column(4,numericInput("house_age", label = p("屋齡(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 0, max = 54.5)),
                  column(4,selectInput("building_type", label = p("建物型態(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('公寓' = 1, '住宅大樓' = 2, '套房' = 3, '透天厝' = 4, '華廈' = 5))),
                  column(4,selectInput("Management_organization", label = p("有無管理組織(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('有' = 1,'無' = 2)))
                ),
                
                fluidRow(
                  column(4,selectInput("use_separation", label = p("使用分區或編定(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('工' = 1, '住' = 2, '其他' = 3, '商' = 4, '農' = 5))),
                  column(4,selectInput("main_use", label = p("主要用途(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('工業用' = 1, '住工用' = 2, '住家用' = 3, '住商用' = 4, '見使用執照' = 5, '見其他登記事項' = 6, '商業用' = 7, '國民住宅' = 8))),
                  column(4,selectInput("building_materials", label = p("主要建材(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('加強磚造' = 1, '見使用執照' = 2, '見其他登記事項' = 3, '預力混凝土造' = 4, '壁式預鑄鋼筋混凝土造' = 5, '磚造' = 6, 
                                                      '鋼骨混凝土造' = 7, '鋼骨鋼筋混凝土造' = 8, '鋼筋混凝土加強磚造' = 9, '鋼筋混凝土造' = 10)))
                ),
                
                fluidRow(
                  column(4,selectInput("rooms", label = p("建物現況格局-房(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                       choices = list('一房' = 1, '兩房' = 2, '三房' = 3, '四房' = 4, '五房' = 5))),
                  column(4,selectInput("halls", label = p("建物現況格局-廳(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                       choices = list('一廳' = 1, '兩廳' = 2, '三廳' = 3, '四廳' = 4, '五廳' = 5))),
                  column(4,selectInput("bathrooms", label = p("建物現況格局-衛(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                       choices = list('一衛' = 1, '兩衛' = 2, '三衛' = 3, '四衛' = 4, '五衛' = 5)))
                ),
                
                fluidRow(
                  column(3,numericInput("land_transfer", label = p("土地移轉總面積(坪)(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 0.3, max = 75.32)),
                  column(3,numericInput("building_transfer", label = p("建物移轉總面積(坪)(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 0.91, max = 215.38)),
                  column(3,numericInput("floor_transfer", label = p("移轉層次(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 1, max = 24)),
                  column(3,numericInput("total_floor", label = p("總樓層數(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 1, max = 38))
                ),
                br(),
                width =12,
                collapsible = TRUE
              ),
              
              fluidRow(
                box(
                  type = "tabs",
                  title = "地圖",status = "warning",solidHeader = TRUE,
                  leafletOutput("taipei_mymap",height=1000),
                  br(),
                  width =12,
                  collapsible = TRUE
                )
              )
      ),
      
      tabItem(tabName = "new_price",
              h2("預測房價"),
              box(
                title = "請填入房屋屬性",status = "warning",solidHeader = TRUE,
                fluidRow(
                  column(8,""),
                  column(4,actionButton("new_predic", label = p("估價",span(style="color:red ; font-size:20px "),style=" font-family:Microsoft YaHei ; font-size:16px "),width = '100%'))
                ),
                
                fluidRow(
                  column(4,selectInput("new_area", label = p("區別(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('八里區',
                                                      '三芝區',
                                                      '三重區',
                                                      '三峽區',
                                                      '土城區',
                                                      '中和區',
                                                      '五股區',
                                                      '永和區',
                                                      '石門區',
                                                      '石碇區',
                                                      '汐止區',
                                                      '板橋區',
                                                      '林口區',
                                                      '金山區',
                                                      '泰山區',
                                                      '貢寮區',
                                                      '淡水區',
                                                      '深坑區',
                                                      '新店區',
                                                      '新莊區',
                                                      '瑞芳區',
                                                      '萬里區',
                                                      '樹林區',
                                                      '雙溪區',
                                                      '蘆洲區',
                                                      '鶯歌區'))),
                  column(4,textInput("new_village", label = p("村里(選填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "))),
                  column(4,textInput("new_Address", label = p("地址路段(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px ")))
                ),
                
                fluidRow(
                  column(4,numericInput("new_house_age", label = p("屋齡(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 0, max = 54.67)),
                  column(4,selectInput("new_building_type", label = p("建物型態(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('公寓' = 1, '住宅大樓' = 2, '套房' = 3, '透天厝' = 4, '華廈' = 5))),
                  column(4,selectInput("new_Management_organization", label = p("有無管理組織(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('有' = 1,'無' = 2)))
                ),
                
                fluidRow(
                  column(4,selectInput("new_use_separation", label = p("使用分區或編定(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('工' = 1, '住' = 2, '其他' = 3, '商' = 4, '農' = 5))),
                  column(4,selectInput("new_main_use", label = p("主要用途(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('工商用' = 1, '工業用' = 2, '住工用' = 3, '住家用' = 4, '住商用' = 5, '見使用執照' = 6, '見其他登記事項' = 7, '商業用' = 8, '國民住宅' = 9))),
                  column(4,selectInput("new_building_materials", label = p("主要建材(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                                       choices = list('加強磚造' = 1, '見其他登記事項' = 2, '磚造' = 3, '鋼骨混凝土造' = 4, '鋼骨鋼筋混凝土造' = 5, '鋼造' = 6, '鋼筋混凝土造' = 7)))
                ),
                
                fluidRow(
                  column(4,selectInput("new_rooms", label = p("建物現況格局-房(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                       choices = list('一房' = 1, '兩房' = 2, '三房' = 3, '四房' = 4, '五房' = 5))),
                  column(4,selectInput("new_halls", label = p("建物現況格局-廳(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                       choices = list('一廳' = 1, '兩廳' = 2, '三廳' = 3, '四廳' = 4, '五廳' = 5))),
                  column(4,selectInput("new_bathrooms", label = p("建物現況格局-衛(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                       choices = list('一衛' = 1, '兩衛' = 2, '三衛' = 3, '四衛' = 4, '五衛' = 5)))
                ),
                
                fluidRow(
                  column(3,numericInput("new_land_transfer", label = p("土地移轉總面積(坪)(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 0.3, max = 193.6)),
                  column(3,numericInput("new_building_transfer", label = p("建物移轉總面積(坪)(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 1.21, max = 447.4)),
                  column(3,numericInput("new_floor_transfer", label = p("移轉層次(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 1, max = 29)),
                  column(3,numericInput("new_total_floor", label = p("總樓層數(必填)",span(style=" font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),"",
                                        min = 2, max = 46))
                ),
                br(),
                width =12,
                collapsible = TRUE
              ),
              
              fluidRow(
                box(
                  type = "tabs",
                  title = "地圖",status = "warning",solidHeader = TRUE,
                  leafletOutput("new_mymap",height=1000),
                  br(),
                  width =12,
                  collapsible = TRUE
                )
              )
      ),
      
      tabItem(tabName = "taipei_information",
              h2("台北標的物資訊"),
              fluidRow(
                box(
                  title = "房價估計值", status = "primary", solidHeader = TRUE, width = 5, collapsible = TRUE,#status可以設定顏色，solidHeader則可以看標題那行是否以status的顏色覆蓋
                  h1(textOutput(outputId="out1"),style = "text-align:center;color:red;font-family: '微軟正黑體'")),
                box(
                  title = "房價估計之信賴區間", status = "primary", solidHeader = TRUE, width = 7, collapsible = TRUE,
                  h1(textOutput(outputId="out2"),style = "text-align:center;color:red;font-family: '微軟正黑體'"))
              ),
              fluidRow(
                box(
                  title = "標的物與各項環境設施之距離圖", status = "primary", solidHeader = TRUE, width = 8, collapsible = TRUE,
                  plotlyOutput(outputId = "dist_plot_taipei", height = "700px")),
                box(
                  title = "最近設施之資料", status = "primary", solidHeader = TRUE, width = 4, collapsible = TRUE,
                  dataTableOutput(outputId = "dist_data_taipei", height = "600px"))
              ),
              fluidRow(
                box(
                  title = "標的物500公尺內設施數量圖", status = "primary", solidHeader = TRUE, width = 8, collapsible = TRUE,
                  plotlyOutput(outputId = "amount_plot_taipei", height = "700px")),
                box(
                  title = "500公尺內設施之資料", status = "primary", solidHeader = TRUE, width = 4, collapsible = TRUE,
                  dataTableOutput(outputId = "amount_data_taipei", height = "600px"))
              ),
              fluidRow(
                box(
                  title = "各區高中低房價數量圖", status = "primary", solidHeader = TRUE, width = 12, collapsible = TRUE,
                  plotlyOutput(outputId = "class_count_taipei", height = "600px"))
              ),
              fluidRow(
                box(
                  title = "各區近兩年房價趨勢圖", status = "primary", solidHeader = TRUE, width = 12, collapsible = TRUE,
                  plotlyOutput(outputId = "price_lines_taipei", height = "600px"))
              )
      ),
      
      tabItem(tabName = "new_information",
              h2("新北標的物資訊"),
              fluidRow(
                box(
                  title = "房價估計值", status = "primary", solidHeader = TRUE, width = 5, collapsible = TRUE,#status可以設定顏色，solidHeader則可以看標題那行是否以status的顏色覆蓋
                  h1(textOutput(outputId="out3"),style = "text-align:center;color:red;font-family: '微軟正黑體'")),
                box(
                  title = "房價估計之信賴區間", status = "primary", solidHeader = TRUE, width = 7, collapsible = TRUE,
                  h1(textOutput(outputId="out4"),style = "text-align:center;color:red;font-family: '微軟正黑體'"))
              ),
              fluidRow(
                box(
                  title = "標的物與各項環境設施之距離", status = "primary", solidHeader = TRUE, width = 8, collapsible = TRUE,
                  plotlyOutput(outputId = "dist_plot_new", height = "600px")),
                box(
                  title = "最近設施之資料", status = "primary", solidHeader = TRUE, width = 4, collapsible = TRUE,
                  dataTableOutput(outputId = "dist_data_new", height = "600px"))
              ),
              fluidRow(
                box(
                  title = "標的物500公尺內設施數量圖", status = "primary", solidHeader = TRUE, width = 8, collapsible = TRUE,
                  plotlyOutput(outputId = "amount_plot_new", height = "600px")),
                box(
                  title = "500公尺內設施之資料", status = "primary", solidHeader = TRUE, width = 4, collapsible = TRUE,
                  dataTableOutput(outputId = "amount_data_new", height = "600px"))
              ),
              fluidRow(
                box(
                  title = "各區高中低房價數量圖", status = "primary", solidHeader = TRUE, width = 12, collapsible = TRUE,
                  plotlyOutput(outputId = "class_count_new", height = "600px"))
              ),
              fluidRow(
                box(
                  title = "各區近兩年房價趨勢圖", status = "primary", solidHeader = TRUE, width = 12, collapsible = TRUE,
                  plotlyOutput(outputId = "price_lines_new", height = "600px"))
              )
      ),
      
      tabItem(tabName = "spider",
              fluidRow(
                box(
                  title = "請輸入查詢資料",status = "warning",solidHeader = TRUE,
                  selectInput("town_spider", label = p("縣市(必填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "),
                              choices = list('台北市','新北市')),
                  textInput("area_spider", label = p("行政區(選填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "), value = "中正區"),
                  textInput("street_spider", label = p("路段(選填)",span(style="color:red ; font-size:12px "),style=" font-family:Microsoft YaHei ; font-size:16px "), value = "博愛路"),
                  numericInput("page","頁數:",min=1,max=10,value=1),
                  actionButton("in2_spider", "search"),
                  width = 12,
                  collapsible = TRUE
                ),
                box(
                  title = "近期販售之物件", status = "primary", solidHeader = TRUE,
                  width = 12,
                  collapsible = TRUE,
                  dataTableOutput(outputId="out2_spider")
                )
              )
      )
    )
  )
    )