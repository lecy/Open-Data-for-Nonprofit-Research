# Open Data for Nonprofit Research


[This project](https://lecy.github.io/Open-Data-for-Nonprofit-Research/) was created to make existing open data assets easily accessible to nonprofit scholars and researchers.

The IRS maintains several important nonprofit databases to track the current population of exempt organizations, their annual 990 filings, and organizations that have closed. This data has been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. In order to make the data accessible to the research community, we have created scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).




<br>

## IRS 990 Open E-Filer Data

Nonprofit sector advocates have waged concerted efforts to make IRS 990 tax data on public charities and foundations available in free, machine-readable formats. As a result of this work the IRS started releasing 990 tax data from electronic filers in June of 2016, roughly 65% of nonprofit filers. 

This release represents a major opportunity for nonprofit scholars as the full 990 data provides a much more extensive window into nonprofit activities than has previously been available. The NCCS dataset on 990 returns used by most scholars focuses primarily on financial variables, whereas the full returns contain information on mission-driven activities, governance, key employees and boards, transparency, compliance, and more. 

This project was created to make this data easily accessible to nonprofit scholars and researchers. We have created programs that convert XML files into flat spreadsheets, and we are posting these on Dataverse for download. You can see the variables currently available in the [E-Filer Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Build_IRS990_E-Filer_Datasets/Data_Dictionary.md).






<br>

## Other Open IRS Databases on Nonprofits

The IRS maintains several important nonprofit databases to track the current population of exempt organizations, their annual 990 filings, and organizations that have closed. 

The following IRS databases can be generated through scripts available by following these links:

* [All Current Exempt Organizations (all orgs granted 501(c)(3) status)](./Open_Nonprofit_Datasets/IRS_Current_Exempt_Orgs_List.Rmd)
* [Business Master File of All Current Exempt Orgs](./Open_Nonprofit_Datasets/IRS_Business_Master_File.Rmd)
* [Index of 990, 990-EZ and 990-PF Electronic Filers from 2010 to Present](./Open_Nonprofit_Datasets/IRS_E-Filers_Index.Rmd)
* [All 990-N Postcard Filers](./Open_Nonprofit_Datasets/IRS_990N_Postcard_Filers.RMD) 
* [All Organizations with a Revoked 501(c)(*) Status](./Open_Nonprofit_Datasets/IRS_Revoked_Exempt_Orgs.Rmd)






<br>










## Long Term Objectives

Nonprofit data can be difficult to use because of messy data, multiple filing options, and changes to the 990 forms over time. 

Since there is a large community of researchers using 990 data, many issues have already been identified and addressed through scripts to clean, re-code, merge, or reconcile data. We are encouraging people to submit their solutions in order to develop collective resources and encourage convergence in how variables like overhead and financial ratios are defined and calculated. 

Our overall project goal is to start cataloging open data assets available to nonprofit scholars, and also to create a library of tools and scripts that help researchers download data, process and clean data, aggregate or wrangle it into specific units of analysis, merge with outside sources, and visualize it in interesting ways.

If you know of datasets that are available and not listed here, please contact us. If you have developed an innovative way to use data in your research, please let us know. We are starting efforts to collect these resources to make people away of opportunities to accelerate, extend, and improve empirical research in the sector.






<br>

## Contact

This project was started by Jesse Lecy (Assistant Professor, Syracuse University) and Nathan Grasse (Assistant Professor, Carleton University). If you are interested in submitting resources or building tools to support nonprofit scholarship please contact us at jdlecy@syr.edu or nathangrasse@cunet.carleton.ca. 

We are currently collaborating with the Urban Institute, Charity Navigator, Guidestar, Boardsource, Aspen Institute, and several academic institutions to move this project forward. 
