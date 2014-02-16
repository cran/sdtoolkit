\name{dimplot}
\alias{dimplot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Plot normalized dimension restrictions as horizontal bars}
\description{
This function takes the output of \code{sdprim} and displays the dimension restrictions for a given box, normalized by the range of the data along each dimension.  
}
\usage{
dimplot(boxseq, boxind=1, alldims = FALSE, thetitle = NULL, 
                incol = "lightblue", longcol = "black")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{boxseq}{A box sequence object, as output by \code{\link{sdprim}}.}
  \item{boxind}{An integer, indicating which box in the box sequence to plot.}
  \item{alldims}{Logical, whether or not to plot all dimensions, or just those that have some dimension restrictions.}
  \item{thetitle}{Character, title to put on the plot.  If none supplied, will default to \dQuote{Normalized Dimension Restrictions}.}
  \item{incol}{What color to use for the portion of the barplot representing the inside-the-box range.  Must be one of those in \code{colors()}.}
  \item{longcol}{What color to use for the portion of the barplot covering values outside the box, extending from zero to unity.  Must be one of those in \code{colors()}.}
}
%\details{
%  
%}
\value{
Nothing returned, used for its plotting capability.
}
%\references{ ~put references to the literature/web site here ~ }
\author{Benjamin P. Bryant, \email{bryant@prgs.edu}}
%\note{ ~~further notes~~ 
%
% ~Make other sections like Warning with \section{Warning }{....} ~
%}
\seealso{See \code{\link{sdprim}} for the primary algorithm, and \code{\link{seqinfo}} for other display options.}
\examples{
#Load an example box object
data(exboxes)

#Plot the first box with only the restricted dimensions shown:
dimplot(exboxes, 1)

#Plot the second box showing all the dimensions, whether or not
#they are restricted:
dimplot(exboxes, 2, alldims=TRUE)
}
\keyword{robust}
\keyword{tree}% __ONLY ONE__ keyword per line
