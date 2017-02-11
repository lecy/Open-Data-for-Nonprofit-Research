## Open Data for Nonprofit Research

This project was created to make existing open data assets easily accessible to nonprofit scholars and researchers. 

The IRS maintains several important nonprofit databases to track the current population of exempt organizations, their annual 990 filings, and organizations that have closed. This data has been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. In order to make the data accessible to the research community, we have created scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).

We have begun the process to catalog and document these resources, and will begin sharing them through the Dataverse Open Data portal:

[NONPROFIT INITIATIVE FOR OPEN DATA](https://dataverse.harvard.edu/dataverse/NIOD)

We have documented and posted the following data assets:

* **IRS E-Filer 990 Data** [Data Dictionary]
* **List of all Current Exempt Organizations (all orgs granted 501(c)(3) status)**  [Data Dictionary] 
* **Business Master File of All Current Exempt Orgs**  [Data Dictionary]
* **Index of 990, 990-EZ and 990-PF Electronic Filers from 2010 to Present**  [Data Dictionary]
* **All 990-N Postcard Filers**  [Data Dictionary]
* **All Organizations with a Revoked 501(c)(.) Status**  [Data Dictionary]


<br>



### Additional Open Data Resources of Note 

There are some additional interesting sources of nonprofit data that have the potential to be leveraged for future research:

* [Pro Publica Nonprofit Explorer API](https://www.propublica.org/nerds/item/announcing-the-nonprofit-explorer-api)
* [Foundation Center API](http://data.foundationcenter.org/about.html)
* [Guidestar APIs](https://community.guidestar.org/groups/developer)
* [Religious Congregation Data](http://www.thearda.com/archive/browse.asp)
* [Dark Money Given to Nonprofits](http://www.opensecrets.org/dark-money/explore-our-reports.php)



<br/>


## IRS E-FIler 990 Returns

The new IRS 990 data repository that was released in June of 2016 is [hosted on an Amazon S3 Cloud Server](https://aws.amazon.com/public-data-sets/irs-990/). 

The release of the data is an important step in making it open and timely (new data is released every couple of months). However, it is currently in XML format and each 990 return is listed on a separate webpage instead of in a single database. This format can be challenging for scholars to work with.

We have created some tools for translating the XML files into a familiar spreadsheet format. We are currently building scripts for each section of the 990 forms in order to generate separate databases for each year of filers. At this early stage we are focusing on the 990 and 990-EZ forms, although the foundation 990-PF files are also available. Datasets are posted on the Dataverse site listed above.


### Liberating the 990 Data

For some background on the campaigns to open access to IRS data, see these articles and blogs:

* [Liberating 990 Data](http://ssir.org/articles/entry/liberating_990_data): Stanford Social Innovation Review
* [The Nonprofit Data Project Blog](https://www.aspeninstitute.org/programs/program-on-philanthropy-and-social-innovation-psi/nonprofit-data-project-updates/): The Aspen Institute
* [IRS Plans to Begin Releasing Electronically Filed Nonprofit Tax Data](https://philanthropy.com/article/IRS-Plans-to-Begin-Releasing/231265): Chronicle of Philanthropy
* [Mandatory E-Filing: Toward a More Transparent Nonprofit Sector](http://www.urban.org/research/publication/mandatory-e-filing-toward-more-transparent-nonprofit-sector): The Urban Institute
* [Recommendations for Improving the Effectiveness of the 990 Form for Reporting](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/IRS%20ACT%20Report%202015.pdf): Advisory Committee on Tax-Exempt and Government Entities (ACT) Report


<br>


### Useful Information About 990 Data

Form 990: A Guide for Newcomers to Nonprofit Research [ [LINK](http://blog.boardsource.org/blog/author/chris-thompson-ph-d-director-of-research-and-evaluation-boardsource) ]

Example Forms:

* [990](./Resources/Form 990-PC 2015.pdf)
* [990-EZ](./Resources/Form 990-EZ 2015.pdf)
* [990-PF](./Resources/Form 990-PF 2015.pdf)
* [990-N Postcard](./Resources/Information Needed to File e-Postcard.pdf)

A History of the Tax Exempt Sector: An SOI Perspective [ [LINK](https://www.irs.gov/pub/irs-soi/tehistory.pdf) ]

A Guided Tour of the 990 Form by GuideStar [ [LINK](https://www.guidestar.org/ViewCmsFile.aspx?ContentID=4208) ]

Revised Form 990: The Evolution of Governance and the Nonprofit World [ [LINK](http://www.thetaxadviser.com/issues/2009/aug/revisedform990theevolutionofgovernanceandthenonprofitworld.html) ]

Wikipedia: History of the 990 [ [LINK](https://en.wikipedia.org/wiki/Form_990#History) ]

* Form 990 was first used for the tax year ending in 1941. It was as a two-page form. Organizations were also required to include a schedule with the names and addresses of payees who had given the organization at least $4,000 during the year.

* The form reached four pages (including instructions) in 1947. In 1976 this was increased to 5.5 pages (including instructions), with 8 pages for Schedule A. By 2000 this was 6 pages for Form 990, 42 pages for instructions, 6 pages for Schedule A, and at least 2 pages for Schedule B. This increase is due to use of a larger font and inclusion of sections that are only required for some organizations.

* Starting in 2000, political organizations were required to file Form 990.

* In June 2007, the IRS released a new Form 990 that requires significant disclosures on corporate governance and boards of directors. These new disclosures are required for all nonprofit filers for the 2009 tax year, with more significant reporting requirements for nonprofits with over $1 million in revenues or $2.5 million in assets.

<br>


### Working with the data on the AWS Platform

Charity Navigator has created an open-source [990 Toolkit](http://990.charitynavigator.org/) that allows you to set up an Amazon EC2 instance and clone the full IRS dataset as a relational database. You can read their press release about the project [here](http://www.charitynavigator.org/index.cfm?bay=content.view&cpid=4669).

You can find some useful scripts here for running queries directly within the cloud and downloading data as CSV files, for example:

https://gist.github.com/ryankanno/a5da4c6f1f8e0136db9623ae1903d23d#form-990

There are some forums on using the E-Filer data, for example:

https://www.reddit.com/r/aws/comments/4p772f/how_the_heck_do_i_view_the_990_documents_on/

<br>





## Authors and Contributors

If you are interested in submitting resources or building tools to support nonprofit scholarship please contact Jesse Lecy (jdlecy@syr.edu) or Nathan Grasse (nathangrasse@cunet.carleton.ca).

Special thanks to Francisco Santamarina for his meticulous work decoding the IRS XML documents to translate the data into a useful format and creating the Data Dictionary at the heart of this project.


### Open Science

This project was inspired by the [R Open Science](https://ropensci.org/) initiative, which believes in making data accessible and building tools that help a research community better utilize the data. These scripts are written in the R language because it is a freely-available open-source platform that can be used by anyone. 







