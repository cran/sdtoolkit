\name{sdtoolkit-package}
\alias{sdtoolkit-package}
\alias{sdtoolkit}
\docType{package}
\title{Scenario Discovery Tools to Support Robust Decision Making
}
\description{
This package is designed to provide a means for easily integrating multiple algorithms for scenario discovery and assessment, an element of the Robust Decision Making process for decisionmaking under uncertainty.  It currently implements a coverage-oriented version of Friedman and Fisher's Patient Rule Induction Method (PRIM), and provides additional diagnostic tools to assess the quality of the scenarios that emerge.  
}
\details{
\tabular{ll}{
Package: \tab sdtoolkit\cr
Type: \tab Package\cr
Version: \tab 2.32-3\cr
Date: \tab 2011-10-10\cr
License: \tab GPL3\cr
Code Copyright: \tab Evolving Logic, Inc.\cr
Documentation Copyright: \tab The RAND Corporation\cr
LazyLoad: \tab yes\cr
}

This package provides interactive functions for scenario discovery that should be usable by those not particularly fluent in R, as well as more direct and powerful code that can be used or extended by those more familiar with both R and the scenario discovery process.  The package is built around the function \code{sdprim} (\dQuote{Scenario Discovery PRIM}), which implements a very interactive, diagnostic-laden, slightly modified version of Friedman and Fisher's Patient Rule Induction Method.  The function \code{sd.start} is a helper function that aids the user in reading in their data, checking for and resolving inappropriate data features, and exploring different output variables and potential thresholds.  

In addition, there are several \dfn{post-discovery} functions that allow the user to visualize the results of running the algorithm(s).  The are currently three high-level functions of interest: \code{seq.info}, which redisplays all information identified by the algorithm, including the definition of all relevant boxes, and statistics for the entire sequence.  The plotting function \code{dimplot} graphically displays normalized dimension restrictions defining a given box, and the plotting function \code{scatterbox} displays boxes over a scatterplot of the dataset, in which the points are color-coded according to their 0/1 value.

Lastly, there are many \dQuote{almost external} functions for which the time constraints on cleaning up and documenting as user-level functions was slightly too high for this round of work.  One line descriptions of all code functions can be found in the \code{\link{undocumented}} help file, which should be useful guidance for anyone looking to capitalize on existing but less thoroughly documented work.
}
\author{
Benjamin P. Bryant
Maintainer: The same \email{bryant@prgs.edu}

Note of Acknowledgment:  The fundamental functions used in the operation of PRIM (specifically, peeling and pasting to form a trajectory of induced boxes) were initially taken from Duong's \pkg{prim} package.  Several pieces of code follow very closely the original functions provided by Duong, however because most functions used required small to large modifications to suit the specific needs of our scenario discovery task, it was easier to integrate these into \pkg{sdtoolkit} rather than build a package dependency on \pkg{prim}.  The internal functions \code{peel.one} and \code{paste.one} were taken almost as is, and the primary workhorse function \code{find.traj} was derived heavily from Duong's \code{find.box}.

The funding for the development of this package came from Evolving Logic, RAND, and a National Science Foundation grant (SES-0345925) to the RAND Corporation. Evolving Logic provided funds for the majority of the customized algorithm implementation, the RAND Pardee Center for Longer Range Global Policy and the Future Human Condition supported the documentation of the package, and the National Science Foundation supported the research that led to the development of the scenario discovery methods employed in this package. 
}

\references{
Bryant, B.P. and R.J. Lempert.  (2010).  \dQuote{Thinking Inside the Box: A Participatory, Computer-Assisted Approach to Scenario Discovery}. \emph{Technological Forecasting and Social Change} 77: 34-49

Lempert, R.J., B.P. Bryant and S.C. Bankes. (2008). \dQuote{Comparing Algorithms for Scenario Discovery}. \emph{RAND Working Paper Series}.  http://www.rand.org/pub/working\_papers/2008/RAND\_WR557.pdf

Friedman, J.H., N.I. Fisher. (1999). \dQuote{Bump hunting in high-dimensional data}. \emph{Statistics and Computing} 9, 123-143.

Groves, D.G. and R.J. Lempert.  (2007). \dQuote{A New Analytic Method for Finding Policy-Relevant Scenarios}. \emph{Global Environmental Change}, 17, p73-85. http://www.rand.org/pubs/reprints/RP1244/

Lempert, R.J., D.G. Groves, et al. (2006). \dQuote{A general, analytic method for generating robust strategies and narrative scenarios}. \emph{Management Science} 52(4): 514-528.
}

\keyword{ package }

\examples{

\dontrun{
#Note that all the examples shown here do not illustrate use of the extra 
#options that can be passed to the functions as additional arguments.  The
#Individual function help files illustrate the use of optional
#arguments in more details.  

#Also, here and in other example sections of code you may see the code preceded 
#by "## Not run:" - this refers to sections of code being exempt from R's 
#automatic example code checking due to their interactive nature.  Lines of code
#that immediately follow "## Not run:" should still be runnable, provided you
#remove the "## Not run:" comment.

### ===== SD.START: =====

#Users not familiar with importing and manipulating data in R will wish to start
#with:

\dontrun{
myboxes <- sd.start()
}

#This will prompt for things like directory and file name, and then walk through 
#data inspection, thresholding, and offer to call sdprim.  


### ===== SDPRIM: =====

#Users confident in the soundness and appropriate formatting of their data may 
#take the following more direct actions: 

\dontrun{

#LOAD the data, either via:
mydata <- read.csv("mycsvfile.csv")

#OR
loadedname <- load("myrdafile.rda")
mydata <- get(loadedname)

#Then define their input variables:
xmatrix <- mydata[,columnindexes]

#Then define their output variable using EITHER
outputvar <- mydata[,outputcolumnnumber]

#OR
outputvar <- mydata[,"outputname"]

#If output var is already a 0-1 variable, then sdprim can be called as:
myboxes <- sdprim(x=xmatrix, y=outputvar)

#Otherwise, first threshold the output variable as follows:
outthresh <- 1*(outputvar>threshold)

#Then call sdprim:
myboxes <- sdprim(x=xmatrix, y=outthresh)
}

### ===== SEQ.INFO: =====

#To see a summary of sdprim output, 
data(exboxes)  #an example box sequence object included with the package
boxinfo <- seq.info(exboxes)


### ===== DIMPLOT: =====

#To see a 'Normalized Dimension Restriction Plot' for box i, type:
data(exboxes)
dimplot(exboxes, 1)

}

}
