R version 3.3.2 (2016-10-31) -- "Sincere Pumpkin Patch"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

```

#below code is copy and modified from https://www.kaggle.com/umeshnarayanappa/explore-video-games-sales/notebook, author is Umesh


```{r}




> library(readr)
> vgsales <- read_csv("C:/Users/yliu3590/Downloads/vgsales.csv")
Parsed with column specification:
cols(
  Rank = col_integer(),
  Name = col_character(),
  Platform = col_character(),
  Year = col_character(),
  Genre = col_character(),
  Publisher = col_character(),
  NA_Sales = col_double(),
  EU_Sales = col_double(),
  JP_Sales = col_double(),
  Other_Sales = col_double(),
  Global_Sales = col_double()
)
> View(vgsales)
> library(sqldf)
Loading required package: gsubfn
Loading required package: proto
Loading required package: RSQLite
Warning messages:
1: package ‘sqldf’ was built under R version 3.3.3 
2: package ‘gsubfn’ was built under R version 3.3.3 
3: package ‘proto’ was built under R version 3.3.3 
4: package ‘RSQLite’ was built under R version 3.3.3 
> library(fmsb)
Warning message:
package ‘fmsb’ was built under R version 3.3.3 
> library(plotly)
Loading required package: ggplot2

Attaching package: ‘plotly’

The following object is masked from ‘package:ggplot2’:

    last_plot

The following object is masked from ‘package:stats’:

    filter

The following object is masked from ‘package:graphics’:

    layout

Warning messages:
1: package ‘plotly’ was built under R version 3.3.3 
2: package ‘ggplot2’ was built under R version 3.3.3 
> df<-read.csv('C:/Users/yliu3590/Downloads/vgsales.csv')
> df[df=="N/A"]<-NA
> df<-df[complete.cases(df),]
> df$Year<-as.numeric(as.character(df$Year))
> df<-df[df$Year<=2016,]
> summary(df)
      Rank                                Name      
 Min.   :    1   Need for Speed: Most Wanted:   12  
 1st Qu.: 4132   FIFA 14                    :    9  
 Median : 8291   LEGO Marvel Super Heroes   :    9  
 Mean   : 8289   Ratatouille                :    9  
 3rd Qu.:12438   Angry Birds Star Wars      :    8  
 Max.   :16600   Cars                       :    8  
                 (Other)                    :16232  
    Platform         Year               Genre     
 DS     :2130   Min.   :1980   Action      :3250  
 PS2    :2127   1st Qu.:2003   Sports      :2304  
 PS3    :1304   Median :2007   Misc        :1686  
 Wii    :1290   Mean   :2006   Role-Playing:1468  
 X360   :1234   3rd Qu.:2010   Shooter     :1282  
 PSP    :1197   Max.   :2016   Adventure   :1274  
 (Other):7005                  (Other)     :5023  
                        Publisher        NA_Sales      
 Electronic Arts             : 1339   Min.   : 0.0000  
 Activision                  :  966   1st Qu.: 0.0000  
 Namco Bandai Games          :  928   Median : 0.0800  
 Ubisoft                     :  917   Mean   : 0.2657  
 Konami Digital Entertainment:  823   3rd Qu.: 0.2400  
 THQ                         :  712   Max.   :41.4900  
 (Other)                     :10602                    
    EU_Sales          JP_Sales         Other_Sales      
 Min.   : 0.0000   Min.   : 0.00000   Min.   : 0.00000  
 1st Qu.: 0.0000   1st Qu.: 0.00000   1st Qu.: 0.00000  
 Median : 0.0200   Median : 0.00000   Median : 0.01000  
 Mean   : 0.1478   Mean   : 0.07885   Mean   : 0.04844  
 3rd Qu.: 0.1100   3rd Qu.: 0.04000   3rd Qu.: 0.04000  
 Max.   :29.0200   Max.   :10.22000   Max.   :10.57000  
                                                        
  Global_Sales   
 Min.   : 0.010  
 1st Qu.: 0.060  
 Median : 0.170  
 Mean   : 0.541  
 3rd Qu.: 0.480  
 Max.   :82.740  
                 
> library(ggplot2)
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

> install.packages("dplyr")
Error in install.packages : Updating loaded packages

Restarting R session...

> install.packages("dplyr")
also installing the dependencies ‘bindr’, ‘bindrcpp’, ‘glue’, ‘tibble’

trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/bindr_0.1.zip'
Content type 'application/zip' length 14704 bytes (14 KB)
downloaded 14 KB

trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/bindrcpp_0.2.zip'
Content type 'application/zip' length 637154 bytes (622 KB)
downloaded 622 KB

trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/glue_1.1.1.zip'
Content type 'application/zip' length 41668 bytes (40 KB)
downloaded 40 KB

trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/tibble_1.3.4.zip'
Content type 'application/zip' length 676367 bytes (660 KB)
downloaded 660 KB

trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/dplyr_0.7.3.zip'
Content type 'application/zip' length 2884750 bytes (2.8 MB)
downloaded 2.8 MB

package ‘bindr’ successfully unpacked and MD5 sums checked
package ‘bindrcpp’ successfully unpacked and MD5 sums checked
package ‘glue’ successfully unpacked and MD5 sums checked
package ‘tibble’ successfully unpacked and MD5 sums checked
package ‘dplyr’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\yliu3590\AppData\Local\Temp\Rtmp86hxuw\downloaded_packages
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

Warning message:
package ‘dplyr’ was built under R version 3.3.3 
> library(DT)
Error in library(DT) : there is no package called ‘DT’
> install.packages("DT")
trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/DT_0.2.zip'
Content type 'application/zip' length 950228 bytes (927 KB)
downloaded 927 KB

package ‘DT’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\yliu3590\AppData\Local\Temp\Rtmp86hxuw\downloaded_packages
> library(DT)
Warning message:
package ‘DT’ was built under R version 3.3.3 
> install.packages("tidyr")
also installing the dependency ‘tidyselect’

trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/tidyselect_0.2.0.zip'
Content type 'application/zip' length 610507 bytes (596 KB)
downloaded 596 KB

trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/tidyr_0.7.1.zip'
Content type 'application/zip' length 893723 bytes (872 KB)
downloaded 872 KB

package ‘tidyselect’ successfully unpacked and MD5 sums checked
package ‘tidyr’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\yliu3590\AppData\Local\Temp\Rtmp86hxuw\downloaded_packages
> install.packages("wesanderson")
trying URL 'https://cloud.r-project.org/bin/windows/contrib/3.3/wesanderson_0.3.2.zip'
Content type 'application/zip' length 19620 bytes (19 KB)
downloaded 19 KB

package ‘wesanderson’ successfully unpacked and MD5 sums checked

The downloaded binary packages are in
	C:\Users\yliu3590\AppData\Local\Temp\Rtmp86hxuw\downloaded_packages
> library(tidyr)
Warning message:
package ‘tidyr’ was built under R version 3.3.3 
> library(wesanderson)
Warning message:
package ‘wesanderson’ was built under R version 3.3.3 
> 
> mycolors <- c("#771C19", "#AA3929", "#8E9CA3", "#556670", "#000000", "#E25033", "#F27314", "#F8A31B", "#E2C59F", "#B6C5CC")
> mytheme_1 <- function() {
+     
+     return(theme(axis.text.x = element_text(angle = 90, size = 10, vjust = 0.4), plot.title = element_text(size = 15, vjust = 2),axis.title.x = element_text(size = 12, vjust = -0.35)))
+     
+ }
> 
> mytheme_2 <- function() {
+     
+     return(theme(axis.text.x = element_text(size = 10, vjust = 0.4), plot.title = element_text(size = 15, vjust = 2),axis.title.x = element_text(size = 12, vjust = -0.35)))
+     
+ }
> ggplot(videogamesales, aes(Year)) + 
+     geom_bar(fill = "blue") +
+     mytheme_1() +
+     ggtitle("Video Game Releases by Year")
Error: could not find function "ggplot"
> 
> revenue_by_year <- videogamesales %>% 
+     group_by(Year) %>%
+     summarize(Revenue = sum(Global_Sales))
Error in eval(expr, envir, enclos) : object 'videogamesales' not found
> 
> ggplot(revenue_by_year, aes(Year, Revenue)) + 
+     geom_bar(fill = "maroon", stat = "identity") +
+     mytheme_1() +
+     ggtitle("Video Game Revenue by Year")
Error: could not find function "ggplot"
> 
> library(ggplot2)
Use suppressPackageStartupMessages() to eliminate
package startup messages.
Warning message:
package ‘ggplot2’ was built under R version 3.3.3 
> ggplot(videogamesales, aes(Year)) + 
+     geom_bar(fill = "blue") +
+     mytheme_1() +
+     ggtitle("Video Game Releases by Year")
Error in ggplot(videogamesales, aes(Year)) : 
  object 'videogamesales' not found
> ggplot(df, aes(Year)) + 
+     geom_bar(fill = "blue") +
+     mytheme_1() +
+     ggtitle("Video Game Releases by Year")
> revenue_by_year <- df %>% 
+     group_by(Year) %>%
+     summarize(Revenue = sum(Global_Sales))
> 
> ggplot(revenue_by_year, aes(Year, Revenue)) + 
+     geom_bar(fill = "maroon", stat = "identity") +
+     mytheme_1() +
+     ggtitle("Video Game Revenue by Year")
> top_publisher_year <- df %>% 
+     group_by(Year, Publisher) %>% 
+     summarize(Revenue = sum(Global_Sales)) %>%
+     top_n(1)
Selecting by Revenue
Warning message:
package ‘bindrcpp’ was built under R version 3.3.3 
> datatable(top_publisher_year)
> ggplot(top_publisher_year, aes(Year, Revenue, fill = Publisher)) + 
+     geom_bar(stat = "identity") +
+     ggtitle("Top Publisher by Revenue each Year") +
+     mytheme_1() +
+     theme(legend.position = "top")
> top_1 <- df %>% 
+     group_by(Year, Genre) %>% 
+     summarize(Revenue = sum(Global_Sales)) %>%
+     top_n(1)
Selecting by Revenue
> datatable(top_1)
> ggplot(top_1, aes(Year, Revenue, fill = Genre)) + 
+     geom_bar(stat = "identity") +
+     ggtitle("Top Genre by Revenue each Year") +
+     mytheme_1() +
+     theme(legend.position = "top") +
+     scale_fill_manual(values = mycolors)
> top_games <- df %>%
+     group_by(Year, Name) %>%
+     summarize(Revenue = sum(Global_Sales)) %>%
+     arrange(desc(Revenue)) %>%
+     top_n(1)
Selecting by Revenue
> datatable(top_games)
> ggplot(top_games, aes(Year, Revenue, fill = Name)) + 
+     geom_bar(stat = "identity") +
+     mytheme_1() +
+     ggtitle("Total Games by Revenue each year") +
+     theme(legend.position = "top")
> top_platforms <- df %>%
+     group_by(Year, Platform) %>%
+     summarize(Revenue = sum(Global_Sales)) %>%
+     arrange(desc(Revenue)) %>%
+     top_n(1)
Selecting by Revenue
> datatable(top_platforms)
> ggplot(top_platforms, aes(Year, Revenue, fill = Platform)) + 
+     geom_bar(stat = "identity") +
+     mytheme_1() +
+     ggtitle("Top Platform by Revenue each year") +
+     theme(legend.position = "top") + 
+     scale_fill_manual(values = mycolors)
> sink(file = "assignment.R")
> bf_str
Error: object 'bf_str' not found
> save(file = "C:/Users/yliu3590/Downloads/assignment.RData")
Warning message:
In save(file = "C:/Users/yliu3590/Downloads/assignment.RData") :
  nothing specified to be save()d
> save.image(file = "C:/Users/yliu3590/Downloads/assignmentImage.RData")