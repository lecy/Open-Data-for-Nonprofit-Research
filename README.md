# Open Data for Nonprofit Research

Nonprofit sector advocates have waged concerted efforts to make IRS 990 tax data on public charities and foundations available in free, machine-readable formats. As a result of this work the IRS released 990 tax data from electronic filers in June of 2016. This project was created to make this data easily accessible to nonprofit scholars and researchers. 

Unfortunately the IRS data has been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. In order to make the data accessible to the research community, we have created scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).





<br>

## Open IRS Databases on Nonprofits

The IRS maintains several important nonprofit databases to track the current population of exempt organizations, their annual 990 filings, and organizations that have closed. 

The following IRS databases can be generated through scripts available by following these links:

* [All Current Exempt Organizations (all orgs granted 501(c)(3) status)](./Build_Datasets/current master exempt list.Rmd)
* [Business Master File of All Current Exempt Orgs](./Build_Datasets/master_exempt_list_w_ntee.Rmd)
* [Index of 990, 990-EZ and 990-PF Electronic Filers from 2010 to Present](./Build_Datasets/electronic filers.Rmd)
* [All 990-N Postcard Filers](./Build_Datasets/postcard 990N filers.RMD) 
* [All Organizations with a Revoked 501(c)(*) Status](./Build_Datasets/revoked organizations.Rmd)






<br>










## Research Tools

Nonprofit data can be difficult to use because of messy data, multiple filing options, and changes to the 990 forms over time. 

Since there is a large community of researchers using 990 data, many issues have already been identified and addressed through scripts to clean, re-code, merge, or reconcile data. We are encouraging people to submit their solutions in order to develop collective resources and encourage convergence in how variables like overhead and financial ratios are defined and calculated. 

Please send your work if it represents solutions to problems that fall under the following categories: 

* Cleaning 990 Data
* Reconciling Data Fields Over Time
* [Merging 990 Data with Other Sources](https://gist.github.com/lecy/0aa782a873cd174573f32d243233ca5b)
* Geocoding Nonprofits


Similarly, if you know of an article, blog, or research vignette that does a good job explaning methods for working with nonprofit data, let us know and we will share it. For example:

*Feng, N. C., Ling, Q., Neely, D., & Roberts, A. A. (2014). Using archival data sources to conduct nonprofit accounting research. Journal of Public Budgeting, Accounting & Financial Management.*

> In an effort to broaden the awareness of the data sources and ensure the quality of nonprofit research, we discuss archival data sources available to nonprofit researchers, data issues, and potential resolutions to those problems. Overall, our paper should raise awareness of data sources in the nonprofit area, increase production, and enhance the quality of nonprofit research.

*Lecy, J., & Thornton, J. (2015). What Big Data Can Tell Us About Government Awards to the Nonprofit Sector Using the FAADS. Nonprofit and Voluntary Sector Quarterly.*

The authors share a script for merging federal contracting data with IRS 990 data using names and addresses of organizations in the absence of a unique key shared by both databases (usually the EIN). The merge script can be accessed [HERE](https://github.com/lecy/FAADS-NCCS-Crosswalk/blob/master/README.md). 


<br>






## Contact

If you are interested in submitting resources or building tools to support nonprofit scholarship please contact Jesse Lecy (jdlecy@syr.edu) or Nathan Grasse (nathangrasse@cunet.carleton.ca). 
