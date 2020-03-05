knitr::opts_knit$set(root.dir = getwd())
knitr::opts_chunk$set(echo = TRUE, results = 'hide')
knitr::opts_chunk$set(warning = FALSE, message=FALSE)
knitr::opts_chunk$set(fig.align="center"
                      ## ,out.width="0.9\\textwidth" # latex
                      ,out.width="60%" # html
                      ,fig.width=5, fig.height=3
                      )

rm(list=ls())
options(digits=4)
options(scipen=100)
graphics.off()
Sys.setlocale("LC_ALL", "Chinese")

knitr::include_graphics("./results/16.png")

knitr::include_graphics("./results/17.png")
knitr::include_graphics("./results/18.png")

knitr::include_graphics("./results/19.png")

knitr::include_graphics("./results/20.png")

knitr::include_graphics("./results/21.png")

knitr::include_graphics("./results/22.png")

knitr::include_graphics("./results/23.png")

knitr::include_graphics("./results/24.png")

knitr::include_graphics("./results/25.png")

library("kableExtra")
tab1 = read.csv('./results/student.csv')
knitr::kable(tab1, row.names =F, align = 'c', caption="学生等级表",longtable = TRUE, booktabs = TRUE, linesep  = "")

library("kableExtra")
tab2 = read.csv('./results/salary.csv')
knitr::kable(tab2, row.names =F, align = 'c', caption="一个工资表（表中有表）实例",longtable = TRUE,  linesep  = "")

library("kableExtra")
tab3 = read.csv('./results/compare.csv')
knitr::kable(tab3, row.names =F, align = 'c', caption="术语对比表",longtable = TRUE, booktabs = TRUE, linesep  = "")

knitr::include_graphics("./results/26.png")
knitr::include_graphics("./results/27.png")

knitr::include_graphics("./results/28.png")

knitr::include_graphics("./results/29.png")

knitr::include_graphics("./results/30.png")
