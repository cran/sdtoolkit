\name{seqinfo}
\alias{seqinfo}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Display Box Sequence Information}
\description{
Function takes a box sequence as output by \code{sdprim}, and prints it nicely to the screen, and also to a text file if desired.
}
\usage{
seqinfo(box.seq, outfile = NA)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{box.seq}{A box sequence object as output by \code{sdprim}.}
  \item{outfile}{A character specifying a filename for outputting a copy of the printed display.  The default \code{NA} argument will not output a file.}
}
%\details{
%}
\value{
  Nothing of value returned, but outputs text to screen, and also to the text file specified in \code{outfile}.
}
%\references{ ~put references to the literature/web site here ~ }
\author{Benjamin P. Bryant, \email{bryant@prgs.edu}}
%\note{ ~~further notes~~ 
%
% ~Make other sections like Warning with \section{Warning }{....} ~
%}
\seealso{\code{\link{sdprim}}, \code{\link{dimplot}}}
\examples{

#Load an example box sequence for demonstration:
data(exboxes)

#Display information about the box sequence:
seqinfo(exboxes)

#Display info, and also print it out:
seqinfo(exboxes, outfile="demofile.txt")

}
\keyword{robust}
\keyword{tree}% __ONLY ONE__ keyword per line
