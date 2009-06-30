\name{sdprim}
\alias{sdprim}

\title{Patient Rule Induction Method Adapted For Scenario Discovery}
\description{This is the primary function for the \code{sdtoolkit} package.  It organizes many subsidiary functions into an interactive session to aid the user in identifying policy-relevant scenarios.  It is based on Friedman and Fisher's PRIM, but includes additional modifications and diagnostics to better suit the scenario discovery task.
}

\usage{
sdprim(x, y = NULL, 
    thresh = NULL, 
    peel.alpha = 0.1, 
    paste.alpha = 0.05, 
    mass.min = 0.001, 
    pasting = TRUE, 
    box.init = NULL, 
    coverage = TRUE, 
    outfile = "boxsum.txt", 
    csvfile = "primboxes.csv", 
    repro = TRUE, 
    nbump = 10, 
    dfrac = 0.5, 
    threshtype = ">")
}

\arguments{
  \item{x}{Matrix of input variables - all values must be numeric at present.  (No non-binary categorical values allowed.)}
  \item{y}{Output vector, which may or may not be thresholded to be zeros and ones.  If not thresholded, you must specify both \code{thresh} and \code{threshtype} below.}
  \item{thresh}{Numeric - if \code{y} is not a zero-one vector, you must specify a real value on which to threshold the data.}
  \item{peel.alpha}{Peeling parameter for PRIM.  Typically around .05 to .1.}
  \item{paste.alpha}{Pasting parameter for PRIM.}
  \item{mass.min}{Minimum fraction of original points that must remain to allow continued peeling.}
  \item{pasting}{Logical indicating whether or not to paste.}
  \item{box.init}{Matrix, providing specification of the initial box bounds, if for some reason you wanted to limit the area over which it searched.  The format is 2 rows by \code{ncol(x)}, with the first row specifying lower bounds on each dimension, and the second row specifying upper bounds.  The matrix should have column names matching \code{colnames(x)}.}
  \item{coverage}{Logical, indicating whether or not to provide coverage-oriented statistics during plotting, rather than support-oriented statistics}
  \item{outfile}{Optional character, naming a text file where the box summary information will be copied.  Set equal to \code{NA} (no quotes) if you would not like a file written out.}
  \item{csvfile}{Optional character, naming a default csv file where CARs-readable output will be sent.  Regardless of what you put here, \code{sdprim} will also ask if you would like to write it out as csv, and give you the chance to change the filename.}
  \item{repro}{Logical, specifying whether or not to automatically generate reproducibility statistics by rerunning PRIM on random samplings of the dataset.  The only reason to set to FALSE is if there is a prohibitively long run time.  Another alternative is to lower the number of resamplings, \code{nbump}, below.}
  \item{nbump}{Integer - If \code{repro = TRUE}, how many resamplings should be performed?  Currently this only allows sampling without replacement.}
  \item{dfrac}{Numeric between 0 and 1.  If \code{repro = TRUE}, what fraction of the dataset should be resampled each time?}
  \item{threshtype}{Required only if the output data is not already in a zero-one formate.  A relational operator entered as a character (either \dQuote{<},\dQuote{>},\dQuote{<=} or \dQuote{>=}, describing how to values in \code{y} should be thresholded.  The threshold is treated as being on the right side of the operator, thus, for example, \dQuote{<} would make all values in \code{y} that are less than than \code{thresh} ones, and all values greater into zeros.}  
}

\details{
Here we discuss several terminology issues that will be useful in understanding the output below, and then describe the interactive process used to identify scenarios.  

This package is generally oriented around producing \dfn{boxes}, which are defined by a set of orthogonal restrictions on the input (uncertainty) space of a model.  In a policy context, a box or set of related boxes can be interpreted as a \dfn{scenario}.  See the references at the end of this entry for a more thorough explanation of the concept of analytically generated scenarios.  

Two important measures of scenario adequacy are termed \dfn{coverage} and \dfn{density}.  These are defined based on the binary output variable, which typically denotes some measure of \dQuote{interestingness} of the input-output combination.  Coverage is the ratio of interesting points (those with an output value of one) captured to the total interesting points in the dataset, and density is the fraction of captured points that are actually interesting (ones in the box to total points in the box).  (These have analogues to Type I and Type II errors and other measures from information theory.)  

The basic PRIM algorithm operates in two steps, first generating a \dfn{trajectory} of boxes (in coverage-density space) that provide a tradeoff frontier for scenarios, with coverage, density and the number of restricted dimensions generally in tension.  From this trajectory, the user selects and further inspects one or more candidate boxes that appropriately balance the measures of interest.  After identifying and possibly modifying a box, the data points contained within that box are removed from the input matrix, and a new trajectory is generated.  This process (\dfn{covering}) can continue until the user is satisfied with the total coverage achieved, or until other conditions prohibit further covering.  The resulting set of \emph{selected} boxes is referred to as a \dfn{box sequence}, and is the primary product of the PRIM algorithm. 

The \code{sdprim} algorithm is very interactive, and the user will receive several prompts while running it.  Note that during this process, at least on MS Windows versions, you will receive a \dQuote{busy} hourglass even when you have an activated R console awaiting user input.  Input can still (must) be entered in this state.  

The first asks whether they would like the peeling trajectory displayed with dimension contours, with dominating points, or in the standard form.  

Dimension contours represent coverage and density values achieved by boxes while holding the total number of restricted dimensions constant.  They do not represent a complete or optimal contour derived by considering the frontier of all possible boxes of a given dimension, but rather simply display the coverage and density associated with boxes that could be created by dropping dimensions (in order of least importance) from other boxes in the current trajectory.  That is, if there is a 3 dimensional box with restrictions x1 < 1, x8 > 5, x2 < 200, then the box defined by x1 < 1 and x8 >5 will be included in the contour for 2-d boxes.  Often, each point on a dimension contour will be defined by different restrictions on the same set of dimensions, but this is not always true.  

Dominating points are those coverage and density combinations which satisfy two conditions:  They are associated with boxes generated by dropping dimensions from those boxes on the trajectory, and they lie \dQuote{above and to the right} of the current trajectory.  That is, they are more simply defined, and also extend the density coverage frontier.  While a dominating point may not represent an overall ideal tradeoff between density, coverage and interpretability, it should be locally preferred to points nearby.

After selecting which display option they would like, the user is then asked to select candidate points from the trajectory displayed.  Clicking on points displays a number for the box associated with that point.  When clicking on points on the original trajectory (denoted by large filled circles), the number shown refers to the index number of exactly that box.  When clicking on dominating points or points on contour lines, the number shown references the box on the trajectory from which the box represented by the point of interest was derived.  That is, points not on the trajectory are all derived by taking some box on the trajectory and removing some dimension restrictions - and the number shown when you click on those points refers to the original full box.  This should be born in mind later on.

After identifying candidate boxes, their statistics are displayed in the R console.  The user then picks a box to consider in more detail.  The program then shows various additional information about the box, and afterwards the user is given the opportunity to drop specific dimension restrictions.  This completes the process of selecting a single box.  The user is then given opportunity to continue \dfn{covering}, in which they repeat the process above on all the data not encompassed by the previously selected box.   
}
\value{

A \dfn{box sequence} object, which is a list, each entry containing a \dfn{box} object (which, in an ideal more formalized world, would be a class).  A box object contains a great deal of information about the particular box in question, including it's definition and associated statistics (described below).  Additionally, the box sequence object contains two attributes, \code{estats} and \code{olap} which are ensemble statistics for the entire box sequence.  While the structure of the output below may be of interest for advanced users, there is no need for the non-R user to be familiar with these outputs, as there are multiple functions for interpreting and displaying the output in a more friendly manner, such as \code{\link{seqinfo}} and \code{\link{dimplot}}.

  \item{y.mean}{Numeric, the mean of the points inside the box.  If the output data is 0-1, then this is the \dfn{density}.  Note that if this is something other than the first box in the sequence, the density is contingent on the covering process up to that point.}
  \item{box}{A 2 by d matrix giving the absolute bounds of the box, including those bounds that were not restricted.  For unrestricted dimension ends, they are taken from the range of the data along that dimension.}
  \item{mass}{The number of points inside the box, expressed as a fraction of the (sub)dataset used to generate this box.  The \dQuote{full} mass can be found in the \code{olap} attribute of the box sequence.}
  \item{dimlist}{A list of three logical vectors (\code{either}, \code{lower}, and \code{upper}), each having length equal to the number of input dimension.  \code{upper} and \code{lower} indicate whether the upper and lower end were restricted, and \code{either} is just an OR of \code{lower} and \code{upper}.  Thus, thus one way to only see the restricted box dimensions is with the code \code{bs[[boxnumber]]$box[,bs[[boxnumber]]$dimlist$either].}, where \sQuote{bs} is replaced by the name of the box sequence object.}
  \item{morestats}{A matrix with one row per restricted box definition, which contains the \dQuote{remove variable} statistics.  The columns are as follows:  Column number in input matrix, density, coverage, support.}
  \item{relcoverage}{Tracks the coverage of the entire trajectory from which this box was taken, with it normalized to the subdataset the box was taken from.}
  \item{pvvalist}{A matrix giving the quasi-p-values for each dimension restriction.}
  \item{freqmat}{A matrix giving the reproducibility statistics (assuming the \code{sdprim} was called with argument \code{repro=TRUE}).  The columns correspond to the columns of the input matrix, and the first row gives the reproducibility statistics when PRIM was matched on coverage, the second when it was matched on density.  The entries represent the fraction of time each dimension was restricted when PRIM was rerun on \code{nbump} random subsamples (of size \code{N*dfrac}) of the dataset.}
  \item{index}{For the sake of reproducibility, this gives the index of the box in the trajectory from which it was selected.  Note that, unless this is the first box in the sequence, the accuracy of this index is contingent on selection of the identical index, dimensions and restrictions for the previous boxes, and parameters for PRIM - ie, it refers to the trajectory that results after the previous boxes in the sequence have been selected.}
  \item{relbox}{A matrix of structure similar to \code{box}, except that the bounds are normalized so that they range from zero to one.  These are used in the \code{\link{dimplot}} command for visualizing dimension restrictions.}
}

\section{Box Sequence Object Attributes}{
The overall box sequence object returns three attributes as well.  The list \code{estats} contains \dQuote{ensemble} statistics for the entire dataset, as follows:

\describe{
  \item{ecov}{Total coverage for the box sequence.}
  \item{esup}{Total support for the box sequence.}
  \item{eden}{Overall density for the space encompassed by the box sequence.}
  \item{npts}{Total points in the dataset used.}
  \item{ninter}{Total number of interesting points in the dataset (after thresholding).}            
  \item{intin}{Total number of interesting points captured by the box sequence.}
  \item{totin}{Total number of points captured by the box sequence.}
  \item{totdims}{Total dimensions in the input data.}
}

The attribute \code{olaps} contains a matrix that holds several pieces of information.  The diagonals display the absolute coverage of box i (in position matrix[i,i]).  The lower triangle displays the the overlap in total interesting points between boxes i and j.  The upper triangle displays the total points in common.  All are expressed as a fraction of total points in the dataset.

Lastly, the attribute \code{data} contains the data used to generate the boxes, augmented by columns full of 0's and 1's.  The first augmented column is named 'in.seq' and gives a 1 for any point that falls in any box in the box set, and the remaining augmented columns are titled 'in.BX', where 'X' is the box number in the box sequence.  To access this data frame, use \code{mynewdata <- attr(myboxes, "data")}.}

\author{Benjamin P. Bryant, \email{bryant@prgs.edu}}

\concept{RDM}
\concept{Robust Decision Making}
\concept{scenario}
\concept{PRIM}

%\note{ ~~further notes~~ 
%
% ~Make other sections like Warning with \section{Warning }{....} ~
%}
\seealso{\code{\link{sd.start}} for reading in and cleaning data, \code{\link{seqinfo}} for viewing the output of \code{sdprim},  and \code{\link{dimplot}} for visualizing dimension restrictions.}
\examples{

#Load some example data to play with:
data(quakes)
#quakes is a 1000 by 5 dataset of earthquake information.  This has no obvious
#policy significance, but we can use this built-in dataset to illustrate the use
#of PRIM.

#Here are the columns:
colnames(quakes)

#We will say magnitude is the output of interest, and call earthquakes greater
#5.0 'interesting.'  We can then call sdprim two different ways.

#First, make an input matrix from columns 1,2,3 and 5 
inputs <- quakes[,c(1:3,5)]  #could also do quakes[,-4]

#Now put our unthresholded y vector:
yout <- quakes[,"mag"] #could also do quakes[,4]

#Now we can either call sdprim and threshold inside PRIM, like this:
\dontrun{myboxes <- sdprim(x=inputs, y=yout, thresh=5.0, threshtype=">")}

#Or we can first threshold yout:
ythresh <- 1*(yout>5.0)

#and then call sdprim without worrying about the thresholds:
\dontrun{myboxes <- sdprim(x=inputs, y=ythresh)}

}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{robust}
\keyword{tree}% __ONLY ONE__ keyword per line

