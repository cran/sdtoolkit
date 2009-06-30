\name{sd.start}
\alias{sd.start}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Read, Clean, And Threshold Data To Call PRIM}
\description{This function is designed to help make sure that data used in PRIM analysis is in an appropriate form.  It checks for duplicate columns and columns with no changing values, and also for various forms of missing or non-real-valued data.  It then displays histograms and empirical cdfs for candidate output variables, and lets you define thresholds, and then call \code{sdprim}.
}
\usage{
sd.start(...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{The function is interactive and prompts for inputs.  However, you may prespecify arguments to pass on to \code{\link{sdprim}} when it is called.  See that function's help file for much more detailed information.}
}
\details{
The current version of \code{sdprim} has some notable restrictions on the format of data it can accept while still functioning appropriately.  In particular, the data must be numeric, and the output vector that is eventually used must be zero one.  This function (\code{sd.start}) helps to make sure the input and output data is appropriately formatted prior to calling \code{sdprim}.
}
\value{
  If one chooses to call \code{sdprim} from within \code{sd.start}, then it will return the same output of \code{sdprim}.  Specifically, a convoluted list containing all relevant box sequence information, with structure as described more precisely in the help file for \code{\link{sdprim}}.  
  
  If \code{sdprim} is not called, then nothing is returned (or possibly some junk), though you may save data files interactively from within \code{sd.start}.
}
\references{
Lempert, R.J., B.P. Bryant and S.C. Bankes. (2008). \dQuote{Comparing Algorithms for Scenario Discovery.} \emph{RAND Working Paper Series}.  http://www.rand.org/pub/working\_papers/2008/RAND\_WR557.pdf

Friedman, J.H., N.I. Fisher. (1999). \dQuote{Bump hunting in high-dimensional data.} \emph{Statistics and Computing} 9, 123-143.

Groves, D.G. and R.J. Lempert.  (2007). \dQuote{A New Analytic Method for Finding Policy-Relevant Scenarios}. \emph{Global Environmental Change}, 17, p73-85. http://www.rand.org/pubs/reprints/RP1244/

Lempert, R.J., D.G. Groves, et al. (2006). \dQuote{A general, analytic method for generating robust strategies and narrative scenarios.} \emph{Management Science} 52(4): 514-528.
}
\author{Benjamin P. Bryant, \email{bryant@prgs.edu}}


\concept{RDM}
\concept{Robust Decision Making}
\concept{scenario}
\concept{PRIM}

\seealso{\code{\link{sdprim}}}
\examples{

#Note, because the function is interactive, this example demonstrates very 
#little.  You will need a csv or rda file available to load data in.
#See the sdprim examples for more explicit use.
 
\dontrun{myboxes <- sd.start()} 
#Uses all of sdprim's default arguments

\dontrun{morebox <- sd.start(repro=FALSE)} 
#tells sdprim not to spend computatioal time on 
#reproducibility statistics
}




\keyword{robust}
\keyword{tree}% __ONLY ONE__ keyword per line
