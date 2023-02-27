# CIComputeR WEB

## Introduction
`CIcomputeR WEB` is a Shiny application which aims to compute two-combination drug synergy using the Chou-Talalay Combination Index (CI). The theoretical basis behind CI computation can be found across various literature, such as [1,2]. In brief, the value of CI can explain whether the combination of two drug treatments shows synergistic, additive, or antagonistic effects by fitting a linear model with respect to treatment group population. 
The program can be accessed here: https://brianjmpark.shinyapps.io/cicomputer/

## Companion R package
`CIcomputer WEB`'s functionalities can be streamlined using the R package `CIcomputeR`, which can be found here: https://rdrr.io/github/snowoflondon/CIcomputeR/. 

## Run-through
The application takes a tabular data containing the two drug concentrations and cell response measurements (typically obtained from a cell viability assay, such as the MTT) as input. The required column headers are as follows:

* `Conc1` = concentration for the one of the drugs.
* `Conc2` = concentration for the other drug.
* `Response` = viability **or** inhibition values in decimals (i.e., <= 1) or in percentages (i.e., <= 100). 

After file input, the user selects whether the values under the column `Response` corresponds to viability or inhibition values and checks the box which indicates whether these values are in decimals or percentages. 

Executing the program generates a table containing the effect size and the calculated CI.

## R dependencies
* `shiny`
* `shinythemes`
* `dplyr`
* `DT`

## R sessionInfo()
```{r}
R version 4.0.5 (2021-03-31)
Platform: x86_64-apple-darwin17.0 (64-bit)
Running under: macOS Big Sur 11.2.3

Matrix products: default
LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib

locale:
[1] en_CA.UTF-8/en_CA.UTF-8/en_CA.UTF-8/C/en_CA.UTF-8/en_CA.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] rsconnect_0.8.25  forcats_0.5.1     stringr_1.4.0     dplyr_1.0.5       purrr_0.3.4       readr_1.4.0       tidyr_1.1.3       tibble_3.1.1     
 [9] ggplot2_3.3.3     tidyverse_1.3.1   DT_0.26           shinythemes_1.2.0 shiny_1.6.0      

loaded via a namespace (and not attached):
 [1] httr_1.4.2          sass_0.4.2          jsonlite_1.7.2      splines_4.0.5       modelr_0.1.8        bslib_0.4.0         assertthat_0.2.1   
 [8] askpass_1.1         BiocManager_1.30.12 cellranger_1.1.0    yaml_2.2.1          pillar_1.6.0        backports_1.2.1     lattice_0.20-41    
[15] glue_1.4.2          digest_0.6.27       promises_1.2.0.1    rvest_1.0.3         colorspace_2.0-0    htmltools_0.5.3     httpuv_1.6.0       
[22] Matrix_1.3-2        pkgconfig_2.0.3     broom_0.7.12        haven_2.4.1         xtable_1.8-4        scales_1.1.1        later_1.2.0        
[29] openssl_1.4.3       mgcv_1.8-34         generics_0.1.0      farver_2.1.0        ellipsis_0.3.1      cachem_1.0.4        withr_2.4.2        
[36] sourcetools_0.1.7   cli_3.1.0           magrittr_2.0.1      crayon_1.4.1        readxl_1.3.1        mime_0.10           memoise_2.0.0      
[43] fs_1.5.0            fansi_0.4.2         nlme_3.1-152        xml2_1.3.3          tools_4.0.5         hms_1.0.0           lifecycle_1.0.0    
[50] munsell_0.5.0       reprex_2.0.0        packrat_0.7.0       compiler_4.0.5      jquerylib_0.1.4     rlang_1.0.6         grid_4.0.5         
[57] rstudioapi_0.13     htmlwidgets_1.5.4   crosstalk_1.1.1     labeling_0.4.2      gtable_0.3.0        curl_4.3            DBI_1.1.1          
[64] R6_2.5.0            lubridate_1.7.10    fastmap_1.1.0       utf8_1.2.1          stringi_1.5.3       Rcpp_1.0.6          vctrs_0.3.7        
[71] dbplyr_2.1.1        tidyselect_1.1.0   
```

## Citations
1. Ashton, John C. "Drug combination studies and their synergy quantification using the Chou–Talalay method." Cancer research 75.11 (2015): 2400-2400.
2. Zhang, Ning, Jia-Ning Fu, and Ting-Chao Chou. "Synergistic combination of microtubule targeting anticancer fludelone with cytoprotective panaxytriol derived from panax ginseng against MX-1 cells in vitro: experimental design and data analysis using the combination index method." American journal of cancer research 6.1 (2016): 97.
