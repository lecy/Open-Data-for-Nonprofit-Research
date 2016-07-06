# Open Data for Nonprofit Research

This project has been created to make data on the nonprofit sector open and easily accessible. Concernted efforts have been waged by advocates to make IRS 990 tax data on public charities and foundations available in free, machine-readable formats. Data on electronic filers was available starting in June of 2016. For some background on these campaigns, see these articles and blogs:

* [Liberating 990 Data](http://ssir.org/articles/entry/liberating_990_data): Stanford Social Innovation Review
* [The Nonprofit Data Project Blog](https://www.aspeninstitute.org/programs/program-on-philanthropy-and-social-innovation-psi/nonprofit-data-project-updates/): The Aspen Institute
* [IRS Plans to Begin Releasing Electronically Filed Nonprofit Tax Data](https://philanthropy.com/article/IRS-Plans-to-Begin-Releasing/231265): Chronicle of Philanthropy

These developments represent significant strides forward in making data open and timely. Unfortunately the data have been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. In order to make the data accessible to the research community, we have created some scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).

Tools are currently available for the following resources:

* [Build the Database of Electronic Filers (990, 990-EZ, 990-PF) from 2011 to Present](./Build Datasets/electronic filers.Rmd)
* [Build the Database of Postcard 990-N Filers](./Build Datasets/postcard 990N filers.RMD) 
* Build the Database of Automatic Revocations of Tax Exempt Status
* Build the Database of All Exempt Organizations



## Research Tools

Nonprofit data can be difficult to use because of messy data, multiple filing options, and changes to the 990 forms over time. 

Since there is a large community of researchers using 990 data, many issues have already been identified and addressed through scripts to clean, code, merge, or reconcile data. We are encouraging people to submit their solutions in order to develop collective resources and encourage convergence in how variables like overhead and financial ratios are defined and calculated. 

Please send your work if it represents solutions to problems that fall under the following categories: 

* Cleaning 990 Data
* Reconciling Data Fields Over Time
* Merging 990 Data with Other Sources
* Geocoding Nonprofits

For instructions on submitting a solution, email Jesse Lecy: jdlecy@syr.edu


## Research Library

If you know of an article, blog, or research vignette that does a good job explaning methods for working with nonprofit data, let us know and we will share it.

*Feng, N. C., Ling, Q., Neely, D., & Roberts, A. A. (2014). Using archival data sources to conduct nonprofit accounting research. Journal of Public Budgeting, Accounting & Financial Management.*

> In an effort to broaden the awareness of the data sources and ensure the quality of nonprofit research, we discuss archival data sources available to nonprofit researchers, data issues, and potential resolutions to those problems. Overall, our paper should raise awareness of data sources in the nonprofit area, increase production, and enhance the quality of nonprofit research.

*Lecy, J., & Thornton, J. (2015). What Big Data Can Tell Us About Government Awards to the Nonprofit Sector Using the FAADS. Nonprofit and Voluntary Sector Quarterly.*

The authors share a script for merging federal contracting data with IRS 990 data using names and addresses of organizations in the absence of a unique key shared by both databases (usually the EIN). It can be accessed [HERE](https://github.com/lecy/FAADS-NCCS-Crosswalk/blob/master/README.md). 




## Useful Information About 990 Data

Example Forms:

* [990](./Resources/Form 990-PC 2015.pdf)
* [990-EZ](./Resources/Form 990-EZ 2015.pdf)
* [990-PF]((./Resources/Form 990-PF 2015.pdf))
* [990-N Postcard](./Resources/Information Needed to File e-Postcard)

A History of the Tax Exempt Sector: An SOI Perspective [ [LINK](https://www.irs.gov/pub/irs-soi/tehistory.pdf) ]

A Guided Tour of the 990 Form by GuideStar [ [LINK](https://www.guidestar.org/ViewCmsFile.aspx?ContentID=4208) ]

Revised Form 990: The Evolution of Governance and the Nonprofit World [ [LINK](http://www.thetaxadviser.com/issues/2009/aug/revisedform990theevolutionofgovernanceandthenonprofitworld.html) ]

Wikipedia: History of the 990 [ [LINK](https://en.wikipedia.org/wiki/Form_990#History) ]

> Form 990 was first used for the tax year ending in 1941. It was as a two-page form. Organizations were also required to include a schedule with the names and addresses of payees who had given the organization at least $4,000 during the year.

> The form reached four pages (including instructions) in 1947. In 1976 this was increased to 5.5 pages (including instructions), with 8 pages for Schedule A. By 2000 this was 6 pages for Form 990, 42 pages for instructions, 6 pages for Schedule A, and at least 2 pages for Schedule B. This increase is due to use of a larger font and inclusion of sections that are only required for some organizations.

> Starting in 2000, political organizations were required to file Form 990.

> In June 2007, the IRS released a new Form 990 that requires significant disclosures on corporate governance and boards of directors. These new disclosures are required for all nonprofit filers for the 2009 tax year, with more significant reporting requirements for nonprofits with over $1 million in revenues or $2.5 million in assets.



## Additional Resources of Note

* Foundation Center API
* Guidestar API
* Religious Congregation Data
* http://www.opensecrets.org/dark-money/explore-our-reports.php
