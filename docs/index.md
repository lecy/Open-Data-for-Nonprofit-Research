# Open Data for Nonprofit Research

The IRS maintains several important nonprofit databases to track the current population of exempt organizations, their annual 990 filings, and organizations that have closed. This data has been released in formats that are not always easy to use - ASCII text files, json files, and XML queries. 

In order to make the data accessible to the research community, we have created scripts to download data from IRS websites, clean and process it, and export into familiar formats (CSV, Stata, SPSS, etc.).

We have begun the process to catalog and document these resources, and will begin sharing them through the Dataverse Open Data portal:

[NONPROFIT INITIATIVE FOR OPEN DATA (NIOD)](https://dataverse.harvard.edu/dataverse/NIOD)

<br>


# Available Data

We have documented and posted the following open data assets:

1. **IRS E-Filer Database:** All nonprofit 990 data that is filed electronically, about 60% of nonprofits.
2. **Index of all E-Filers from 2009 to Present:** A list of all organizations that have electronically filed each year.
3. **Current Exempt Organizations:** The current list of all tax-exempt organizations.
4. **IRS Business Master File:** Organizational characteristics of all current exempt organizations.
5. **990N Postcard Filers:** Data on nonprofits that are small enough to file the abbreviated "postcard" version of the 990 form.
6. **IRS Automatic Revocations:"** Database of nonprofits that had their tax exempt status revoked for failing to file.
7. **Organizations Granted Tax Exempt Status through 1023-EZ Form:** Data filed electronically on the new shorter 1023-EZ application for 501(c) status.

<br>
The National Center for Charitable Statistics at the Urban Institute has opened up their data archives!

[NCCS Open Data Portal](http://nccs-data.urban.org/index.php)


<br>

## (1) IRS E-Filer 990 Data 

The IRS has released all nonprofit 990 tax data that has been e-filed through their online system, approximately 60-65% of all 990-PC and 990-EZ filers. It is available for years 2012 to current years with a small set of returns avaialable for 2010 and 2011. The data has been posted as XML files in an [Amazon Web Server (AWS) Cloud Server](https://aws.amazon.com/public-datasets/irs-990/). More details about the data and the push to have it made public are below.

In order to support use of this data, we have converted the XML files into a research database similar to the NCCS Core dataset.

 **FORM** | 2009 |  2010 |  2011  | 2012  | 2013  | 2014 |  2015
-------|-------|--------|-------|-------|------|-------|------- 
**990**  | 33,360 | 123,107 | 159,539 | 179,675 | 198,615 | 215,764 | 73,233
**990EZ** | 15,500 | 63.253 |  82,066 |  93,769 | 104,425  | 114,822  | 60,967
**990PF**  | 2,352 | 25,275  | 34,597  | 39,936 | 45,870  | 52,617  | 34,387

Check out a quick guide to working with XML files in R: [ [HTML](Quick_Guide_to_XML_in_R.html) ]  [ [PDF](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Quick_Guide_to_XML_in_R.pdf) ]

You can download the data in CSV and RDS formats here:  [ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Build_IRS990_E-Filer_Datasets/Data_Dictionary.md) ] [ Link to Dataset ]


#### Liberating the 990 Data

For some background on the campaigns to open access to IRS data, see these articles and blogs:

* [Liberating 990 Data](http://ssir.org/articles/entry/liberating_990_data): Stanford Social Innovation Review
* [The Nonprofit Data Project Blog](https://www.aspeninstitute.org/programs/program-on-philanthropy-and-social-innovation-psi/nonprofit-data-project-updates/): The Aspen Institute
* [IRS Plans to Begin Releasing Electronically Filed Nonprofit Tax Data](https://philanthropy.com/article/IRS-Plans-to-Begin-Releasing/231265): Chronicle of Philanthropy
* [Mandatory E-Filing: Toward a More Transparent Nonprofit Sector](http://www.urban.org/research/publication/mandatory-e-filing-toward-more-transparent-nonprofit-sector): The Urban Institute
* [Recommendations for Improving the Effectiveness of the 990 Form for Reporting](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/IRS%20ACT%20Report%202015.pdf): Advisory Committee on Tax-Exempt and Government Entities (ACT) Report





#### Working With 990 Data

Example Forms:

* [990](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Form%20990-PC%202015.pdf)
* [990-EZ](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Form%20990-EZ%202015.pdf)
* [990-PF](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Form%20990-PF%202015.pdf)
* [990-N Postcard](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/Information%20Needed%20to%20File%20e-Postcard.pdf)

Form 990: A Guide for Newcomers to Nonprofit Research [ [LINK](http://blog.boardsource.org/blog/form-990-a-guide-for-newcomers-to-nonprofit-research) ]

A History of the Tax Exempt Sector: An SOI Perspective [ [LINK](https://www.irs.gov/pub/irs-soi/tehistory.pdf) ]

A Guided Tour of the 990 Form by GuideStar [ [LINK](https://learn.guidestar.org/help/highlights-of-irs-form-990) ]

Revised Form 990: The Evolution of Governance and the Nonprofit World [ [LINK](http://www.thetaxadviser.com/issues/2009/aug/revisedform990theevolutionofgovernanceandthenonprofitworld.html) ]

Wikipedia: History of the 990 [ [LINK](https://en.wikipedia.org/wiki/Form_990#History) ]



#### Resources for the AWS Data

Charity Navigator has created an open-source [990 Toolkit](http://990.charitynavigator.org/) that allows you to set up an Amazon EC2 instance and clone the full IRS dataset as a relational database. You can read their press release about the project [here](http://www.charitynavigator.org/index.cfm?bay=content.view&cpid=4669).

Chad Kruse at SmarterGiving has a script to convert 990-PF XML files into a MongoDB database on GitHub [here](https://github.com/smartergiving/irs-990-fetch).

You can find some useful scripts here for running queries directly within the cloud and downloading data as CSV files, for example [this GitHub gist](https://gist.github.com/ryankanno/a5da4c6f1f8e0136db9623ae1903d23d#form-990).

If you are more comfortable in Python, check out Yash Nanavati's [GitHup repo](https://github.com/yashvardhannanavati/IRS990-Data-Analysis).

There are some forums on using the E-Filer data, for example [this reddit forum](https://www.reddit.com/r/aws/comments/4p772f/how_the_heck_do_i_view_the_990_documents_on/).



<br>



## (2) Index of 990, 990-EZ and 990-PF Electronic Filers from 2009 to Present

We provide an R script that builds the INDEX file (not the full dataset) for all IRS E-Filer open data provided on the Amazon Web Server. The index contains a limited number of variables such as nonprofit name, EIN, tax year, form type, and the URL link to the XML form of the 990 return data. This index file allows you to see what is available in the open E-Filer database.

 **FORM** | 2009 |  2010 |  2011  | 2012  | 2013  | 2014 |  2015
-------|-------|--------|-------|-------|------|-------|------- 
**990**  | 33,360 | 123,107 | 159,539 | 179,675 | 198,615 | 215,764 | 73,233
**990EZ** | 15,500 | 63.253 |  82,066 |  93,769 | 104,425  | 114,822  | 60,967
**990PF**  | 2,352 | 25,275  | 34,597  | 39,936 | 45,870  | 52,617  | 34,387


[ [Data Dictionary] ](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_E-Filers_Index.Rmd)  [Link to Dataset]

<br>




## (3) List of all Current Exempt Organizations (all orgs granted 501(c)(3) status)  


The [IRS Publication 78](https://apps.irs.gov/app/eos/forwardToPub78Download.do) contains a list of all organizations that currently have 501(c)(3) tax exempt status and are in good standing (eligible to receive tax-deductible donations) under IRS code.


[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_Current_Exempt_Orgs_List.Rmd) ]  [ [Link to Dataset](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/Z4PZOG) ]


<br>


## (4) Business Master File of All Current Exempt Orgs

The [IRS Exempt Organization Business Master File Extract (EO BMF)](https://www.irs.gov/charities-non-profits/exempt-organizations-business-master-file-extract-eo-bmf) contains information on all active nonprofits including basic information about nonprofit location, ruling date (when they were granted tax exempt status), and activities. Note that the NTEE codes are noisy and incomplete. It is recommended to use the NCCS codes instead.

[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_Business_Master_File.Rmd) ]  [ [Link to Dataset](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ZPHJYA) ]




<br>



## (5) All 990-N Postcard Filers

Most small tax-exempt organizations whose annual gross receipts are normally $50,000 or less can satisfy their annual reporting requirement by electronically submitting Form 990-N if they choose not to file Form 990 or Form 990-EZ instead. Exceptions to this requirement include:

* Organizations that are included in a group return
* Churches, their integrated auxiliaries, and conventions or associations of churches
* Organizations required to file a different return

The Postcard Filers dataset contains close to a million cases from the following years:

 2007 |  2008 |  2009 |  2010 |  2011  | 2012  | 2013  | 2014 |  2015 |  2016 
------|-------|-------|-------|--------|-------|-------|------|-------|-----------
26,969 | 28,704 | 45,846 | 31,734 | 36,457  | 36,779 | 52,202 | 120,831 | 475,084  | 65,211 

<br>

[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_990N_Postcard_Filers.RMD) ]  [ [Link to Dataset](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/ZQMJAL) ]


<br>

## (6) All Organizations with a Revoked 501(c)(.) Status

Nonprofits that fail to file 990 returns for three years have their 501(c)(3) tax exempt status automatically revoked by the IRS. This dataset contains more than 670,000 cases for the following years:

2010 |  2011 |  2012 |  2013 |  2014 |  2015  | 2016
-----|-------|-------|-------|-------|--------|-------
372,717 |  92,360  | 47,506  |  52,111  | 36,973  | 36,935  | 35,046  

<br>

[ [Data Dictionary](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Open_Nonprofit_Datasets/IRS_Revoked_Exempt_Orgs.Rmd) ]  [ [Link to Dataset](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/BETUJF) ]


<br>


## (7) Organizations Granted Tax Exempt Status through 1023-EZ Form

This dataset contains information on nonprofits that have been granted tax-exempt status through the new 1023-EZ form, a more compact and simplified version of the original 1023 form. These data do not include organizations that filed for exempt status through the original 1023 form, nor those that filed via paper forms sent to the IRS through the mail. The forms and criteria for submitting a 1023-EZ can be found here:

[ [1023-EZ Documentation](https://www.irs.gov/uac/about-form-1023ez)  ]  
[ [1023 Documentation](https://www.irs.gov/uac/about-form-1023)  ]  

Current sample sizes are at:

2014    |  2015    |  2016    |
--------|----------|----------|
15,160  |  42,392  | 47,557   |

<br>

[ [Data Dictionary](https://www.irs.gov/pub/irs-tege/f1023ez_infosheet.pdf) ]  [ [Link to Dataset](https://www.irs.gov/charities-non-profits/exempt-organizations-form-1023ez-approvals) ]


<br> 


# Additional Open Data Resources of Note 

There are some additional interesting sources of nonprofit data that have the potential to be leveraged for future research:

**County Level Measures of Social Capital**
* [Data](http://aese.psu.edu/nercrd/community/social-capital-resources)
* [Data Dictionary](http://aese.psu.edu/nercrd/community/social-capital-resources/social-capital-variables-for-1997-2005-and-2009/data-dictionary-sk-variables)
* Data available for 1990, 1997, 2005, and 2009

**Religious Congregation Data**
* Measures of Church Numbers and Membership from 1950 to 2010
* [Link to Association of Religion Data Archives](http://www.thearda.com/archive/browse.asp)

**Marc Joffe's Federal Audit Clearinghouse Harvester**
* [Link to Federal Website](https://harvester.census.gov/facdissem/SearchA133.aspx)
* [Marc's Online Repository of Audits](http://www.govwiki.info/pdfs/Non-Profit/)
* [GitHub Repo of Harvesting Scripts](https://github.com/govwiki/SingleAuditRepo)

**Notable APIs for Nonprofit Data**
* [Pro Publica Nonprofit Explorer API](https://www.propublica.org/nerds/item/announcing-the-nonprofit-explorer-api)
* [Foundation Center API](http://data.foundationcenter.org/about.html)
* [Guidestar APIs](https://community.guidestar.org/groups/developer)
* [Dark Money Given to Nonprofits](http://www.opensecrets.org/dark-money/explore-our-reports.php)


**State of Indiana's Audit Clearinghouse**
* [Link to the Portal](https://gateway.ifionline.org)
* *Click on “Report Builder”, then “Entity Annual Report” and then “Entity Annual Report”.*
* [Log of 2015 Nonprofit Audits](https://github.com/lecy/Open-Data-for-Nonprofit-Research/blob/master/Resources/sboa_e1_submission_log_2015.csv)
* Example of organizations included:

| Category Group                              | Number Audited in 2015 | 
|---------------------------------------------|-----------------------------------------------| 
| 4H-CLUB                                     | 62                                            | 
| ART FOUNDATIONS/CENTERS                     | 114                                           | 
| BIG BROTHERS/BIG SISTERS                    | 6                                             | 
| BOYS & GIRLS CLUBS                          | 31                                            | 
| CAP AGENCIES                                | 29                                            | 
| CEMETERY                                    | 2                                             | 
| CHURCH                                      | 40                                            | 
| CIVIC ORGANIZATIONS/CLUBS                   | 8                                             | 
| COUNCIL ON AGING                            | 43                                            | 
| COUNTY FAIR ORGANIZATION                    | 21                                            | 
| CRISIS CENTER                               | 48                                            | 
| DAY CARE CENTER                             | 92                                            | 
| ECONOMIC DEVELOPMENT CORP.                  | 128                                           | 
| EDUCATIONAL ORGANIZATION                    | 185                                           | 
| ELECTRIC UTILITY                            | 1                                             | 
| EMERGENCY MEDICAL SERVICES                  | 34                                            | 
| EMPLOYMENT & TRAINING CORP.                 | 30                                            | 
| FOR PROFIT CORPORATION                      | 15                                            | 
| HANDICAPPED CENTER                          | 37                                            | 
| HEALTH SERVICE ORGANIZATION                 | 83                                            | 
| HISTORICAL SOCIETY                          | 49                                            | 
| HOSPITALS                                   | 50                                            | 
| HUMANE SOCIETY                              | 35                                            | 
| LEGAL AID                                   | 3                                             | 
| LIBRARY                                     | 5                                             | 
| MENTAL HEALTH ORGANIZATIONS                 | 39                                            | 
| MENTALLY HANDICAPPED CTRS                   | 40                                            | 
| ORCHESTRA/SYMPHONY/THEATRE                  | 69                                            | 
| OTHER NOT-FOR-PROFIT                        | 386                                           | 
| OTHER SPECIAL DISTRICT                      | 1                                             | 
| PLANNED PARENTHOOD ASSOCIATION              | 1                                             | 
| RED CROSS                                   | 1                                             | 
| REG WASTEWATER(SEWER) DISTRICT              | 1                                             | 
| SENIOR CITIZEN CENTER                       | 33                                            | 
| TOURISM & PROMOTION BUREAU                  | 56                                            | 
| UNITED WAY                                  | 4                                             | 
| VETERANS ORGANIZATION                       | 4                                             | 
| VOLUNTEER FIRE DEPARTMENT                   | 442                                           | 
| WATER CORPORATION -NFP                      | 1                                             | 
| YMCA/YWCA                                   | 29                                            | 
| YOUTH SERVICE BUREAU                        | 33                                            | 
| YOUTH SPORTS ORGANIZATION                   | 13                                            | 





<br/>







## Authors and Contributors

If you are interested in submitting resources or building tools to support nonprofit scholarship please contact Jesse Lecy (jdlecy@syr.edu) or Nathan Grasse (nathangrasse@cunet.carleton.ca).

Special thanks to Francisco Santamarina for his meticulous work decoding the IRS XML documents to translate the data into a useful format and creating the Data Dictionary at the heart of this project.


### Open Science

This project was inspired by the [R Open Science](https://ropensci.org/) initiative, which believes in making data accessible and building tools that help a research community better utilize the data. These scripts are written in the R language because it is a freely-available open-source platform that can be used by anyone. 







