# Open Data for Nonprofit Research

Nonprofit sector advocates have waged concerted efforts to make IRS 990 tax data on public charities and foundations available in free, machine-readable formats. As a result of this work the IRS released 990 tax data from electronic filers in June of 2016. This project was created to make this data easily accessible to nonprofit scholars and researchers. 

Unfortunately the IRS data has been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. In order to make the data accessible to the research community, we have created scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).

We have begun the process to catalog and document these resources, and will begin sharing them through the Dataverse Open Data portal:

[NONPROFIT INITIATIVE FOR OPEN DATA](https://dataverse.harvard.edu/dataverse/NIOD)

<br>

## Open IRS Databases on Nonprofits

The IRS maintains several important nonprofit databases to track the current population of exempt organizations, their annual 990 filings, and organizations that have closed. 

The following IRS databases can be generated through scripts available by following these links:

* [All Current Exempt Organizations (all orgs granted 501(c)(3) status)](./Build_Datasets/current master exempt list.Rmd)
* [Business Master File of All Current Exempt Orgs](./Build_Datasets/master_exempt_list_w_ntee.Rmd)
* [Index of 990, 990-EZ and 990-PF Electronic Filers from 2010 to Present](./Build_Datasets/electronic filers.Rmd)
* [All 990-N Postcard Filers](./Build_Datasets/postcard 990N filers.RMD) 
* [All Organizations with a Revoked 501(c)(*) Status](./Build_Datasets/revoked organizations.Rmd)

This project was inspired by the [R Open Science](https://ropensci.org/) initiative, which believes in making data accessible and building tools that help a research community better utilize the data. These scripts are written in the R language because it is a freely-available open-source platform that can be used by anyone. 

You can install R for Windows [here](https://cran.r-project.org/bin/windows/base/) or R for Macs [here](https://cran.r-project.org/bin/macosx/). To build these datasets from scratch you can copy and paste the script into an R console, then select the desired output, and it will generate a CSV, SPSS, or Stata dataset for you.

<br>

## IRS E-FIler 990 Returns

The new IRS 990 data repository that was released in June of 2016 is [hosted on an Amazon S3 Cloud Server](https://aws.amazon.com/public-data-sets/irs-990/). 

The release of the data is an important step in making it open and timely (new data is released every couple of months). However, it is currently in XML format and each 990 return is listed on a separate webpage instead of in a single database. This format can be challenging for scholars to work with.

We have created some tools for translating the XML files into a familiar spreadsheet format. We are currently building scripts for each section of the 990 forms in order to generate separate databases for each year of filers. At this early stage we are focusing on the 990 and 990-EZ forms, although the foundation 990-PF files are also available. Once these databases are generated they will be posted on the Dataverse site listed above.

In the meantime you can find documentation and follow progress here:

[Building E-Filer Databases](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/E-FILERS.md)


<br>



## Liberating the 990 Data

For some background on the campaigns to open access to IRS data, see these articles and blogs:

* [Liberating 990 Data](http://ssir.org/articles/entry/liberating_990_data): Stanford Social Innovation Review
* [The Nonprofit Data Project Blog](https://www.aspeninstitute.org/programs/program-on-philanthropy-and-social-innovation-psi/nonprofit-data-project-updates/): The Aspen Institute
* [IRS Plans to Begin Releasing Electronically Filed Nonprofit Tax Data](https://philanthropy.com/article/IRS-Plans-to-Begin-Releasing/231265): Chronicle of Philanthropy
* [Mandatory E-Filing: Toward a More Transparent Nonprofit Sector](http://www.urban.org/research/publication/mandatory-e-filing-toward-more-transparent-nonprofit-sector): The Urban Institute
* [Recommendations for Improving the Effectiveness of the 990 Form for Reporting](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/IRS%20ACT%20Report%202015.pdf): Advisory Committee on Tax-Exempt and Government Entities (ACT) Report


<br>



## Useful Information About 990 Data

A nice primer on using the 990s for research:

[Form 990: A Guide for Newcomers](http://blog.boardsource.org/blog/author/chris-thompson-ph-d-director-of-research-and-evaluation-boardsource)

Example Forms:

* [990](./Resources/Form 990-PC 2015.pdf)
* [990-EZ](./Resources/Form 990-EZ 2015.pdf)
* [990-PF]((./Resources/Form 990-PF 2015.pdf))
* [990-N Postcard](./Resources/Information Needed to File e-Postcard)

A History of the Tax Exempt Sector: An SOI Perspective [ [LINK](https://www.irs.gov/pub/irs-soi/tehistory.pdf) ]

A Guided Tour of the 990 Form by GuideStar [ [LINK](https://www.guidestar.org/ViewCmsFile.aspx?ContentID=4208) ]

Revised Form 990: The Evolution of Governance and the Nonprofit World [ [LINK](http://www.thetaxadviser.com/issues/2009/aug/revisedform990theevolutionofgovernanceandthenonprofitworld.html) ]

Wikipedia: History of the 990 [ [LINK](https://en.wikipedia.org/wiki/Form_990#History) ]

* Form 990 was first used for the tax year ending in 1941. It was as a two-page form. Organizations were also required to include a schedule with the names and addresses of payees who had given the organization at least $4,000 during the year.

* The form reached four pages (including instructions) in 1947. In 1976 this was increased to 5.5 pages (including instructions), with 8 pages for Schedule A. By 2000 this was 6 pages for Form 990, 42 pages for instructions, 6 pages for Schedule A, and at least 2 pages for Schedule B. This increase is due to use of a larger font and inclusion of sections that are only required for some organizations.

* Starting in 2000, political organizations were required to file Form 990.

* In June 2007, the IRS released a new Form 990 that requires significant disclosures on corporate governance and boards of directors. These new disclosures are required for all nonprofit filers for the 2009 tax year, with more significant reporting requirements for nonprofits with over $1 million in revenues or $2.5 million in assets.

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


## Additional Resources of Note 

Can we develop these further to augment the IRS data in interesting ways?

* [Pro Publica Nonprofit Explorer API](https://www.propublica.org/nerds/item/announcing-the-nonprofit-explorer-api)
* [Foundation Center API](http://data.foundationcenter.org/about.html)
* [Guidestar APIs](https://community.guidestar.org/groups/developer)
* [Religious Congregation Data](http://www.thearda.com/archive/browse.asp)
* [Dark Money Given to Nonprofits](http://www.opensecrets.org/dark-money/explore-our-reports.php)

Working with the data on the AWS Platform:

You can find some useful scripts here for running queries directly within the cloud and downloading data as CSV files:

https://gist.github.com/ryankanno/a5da4c6f1f8e0136db9623ae1903d23d#form-990

<br>




## Contact

If you are interested in submitting resources or building tools to support nonprofit scholarship please contact Jesse Lecy (jdlecy@syr.edu) or Nathan Grasse (nathangrasse@cunet.carleton.ca). 
