\name{scatterbox}
\alias{scatterbox}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Plot scatterplots of data with boxes shown}
\description{
  Function for plotting scatterplots of cases, with points color-coded by relevance and with two-dimensional projections of scenarios-as-boxes.
}
\usage{
scatterbox(boxseq, boxnum = 1, xdim, ydim, filterdims = FALSE, 
  filterothers = FALSE, nobox = FALSE, addbox = FALSE, 
  data = attr(boxseq, "data"), y = NULL, manualbox = FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{boxseq}{A box sequence object as ouput by sdprim.  Alternatively, a manually created list of box definitions (see \code{details}.}
  \item{boxnum}{Integer - Which box in the box sequence should be plotted?}
  \item{xdim}{Integer or Character - Which dimension should be plotted as the x-axis?  The safest way is to specify the dimension name.  See \code{details}.}
  \item{ydim}{Integer or Character - Which dimension should be plotted as the y-axis?  The safest way is to specify the dimension name.  See \code{details}.}
  \item{filterdims}{Logical - If a box is defined by more than just the two dimensions that are being plotted, should points filtered out by the other dimensions be removed from the scatter plot?  See \code{details}.}
  \item{filterothers}{Specifies whether and how points captured by other boxes should be filtered out.  Either TRUE, FALSE, \dQuote{PREV} or a vector of numerics.  TRUE removes points captured by all other boxes.  FALSE removes none.  \dQuote{PREV} removes any boxes that came earlier in the covering sequence.  Alternatively, a vector of integers may be specified indicating which boxes should have their points removed.  Note that in all cases, boxes may overlap and specifying this option may result in not all points in the current box being shown.}
  \item{nobox}{Logical - should the scatterplot be generated, but with no box plotted?}
  \item{addbox}{Logical - should a different box be plotted on the same scatterplot?  Note that depending on how points were filtered and which dimensions are involved, this may or may not be misleading.}
  \item{data}{Matrix - the data to use in generating the scatterplots.  The default is to use the data attribute returned by sdprim.  If this is not used for some reason (such as training versus test data), the dataset should have the same number of dimensions, same dimension names, and same dimension ordering as that used to generate the boxes.}
  \item{y}{Vector of zeros and ones indicating interestingness or uninterestingness of points.  If left as NULL, it will assume the item \code{data} above is of the form returned by \code{sdprim}.}
  \item{manualbox}{Logical - Is the \code{boxseq} argument given a manually generated box list not conforming to the output of \code{sdprim}?  This may be handy if you want to plot boxes or box sequences that you specified yourself independent of \code{sdprim}.  See \code{details} for how to construct such a box.} 
  \item{\dots}{Arguments that may be passed on to \code{pbox} and \code{colptplot}.}
}
%\details{
%  
%}
\value{
  Nothing returned, used for its plotting capabilities.
}
\references{RAND Pardee Center: http://www.rand.org/international\_programs/pardee/}
\author{Benjamin P. Bryant, \email{bryant@prgs.edu}}
%\note{
% ~Make other sections like Warning with \section{Warning }{....} ~
%}
%\seealso{ ~~objects to See Also as \code{\link{help}}, ~~~ }
\examples{
data(exboxes)
scatterbox(exboxes,xdim="stations",ydim="depth") 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{aplot}
\keyword{robust}% __ONLY ONE__ keyword per line
