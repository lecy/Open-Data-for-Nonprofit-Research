### Open Data
As of June, 2016 the IRS has begun releasing 990 tax data from electronic filers. This project was created to make this data easily accessible to nonprofit scholars and researchers. 

This project was inspired by the open science movement, an initiative that pushes to make data accessible and to create tools that help the research community better utilize the data. These scripts to create datasets are written in the R language because it is a freely-available open-source platform that can be used by anyone. Once generated, datasets are being posted to the [Dataverse open data portal](https://dataverse.harvard.edu/dataverse/NIOD).

### Data Availability
The IRS maintains several important nonprofit databases to track the current population of exempt organizations, their annual 990 filings, and organizations that have closed.

* [All Current Exempt Organizations (all orgs granted 501(c)(3) status)](./Build_Datasets/current master exempt list.Rmd) 
* [Business Master File of All Current Exempt Orgs](./Build_Datasets/master_exempt_list_w_ntee.Rmd) 
* [Index of 990, 990-EZ and 990-PF Electronic Filers from 2010 to Present](./Build_Datasets/electronic filers.Rmd) 
* [All 990-N Postcard Filers](./Build_Datasets/postcard 990N filers.RMD) 
* [All Organizations with a Revoked 501(c)(*) Status](./Build_Datasets/revoked organizations.Rmd) 

### Data Formats
The IRS data has been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. In order to make the data accessible to the research community, we have created scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).

### Authors and Contributors
If you are interested in submitting resources or building tools to support nonprofit scholarship please contact Jesse Lecy (jdlecy@syr.edu) or Nathan Grasse (nathangrasse@cunet.carleton.ca).



