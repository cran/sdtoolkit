\name{undocumented}
\alias{undocumented}
\alias{beval}
\alias{boxconverter}
\alias{colptplot}
\alias{contourmkr}
\alias{csvboxes}
\alias{dimchecker}
\alias{dupcolchecker}
\alias{filterpts}
%\alias{find.box}
\alias{find.traj}
\alias{boxformat}
\alias{in.box}
\alias{in.box.seq}
\alias{lvout}
\alias{nicecat}
\alias{nullprob}
\alias{olaps}
%\alias{overlap.box}
%\alias{overlap.box.seq}
\alias{paste.one}
\alias{pbox}
\alias{peel.one}
\alias{pquantile}
%\alias{prim.box}
%\alias{prim.combine}
%\alias{prim.hdr}
%\alias{prim.one}
\alias{prim.traj}
\alias{boxprint}
\alias{pvallister}
\alias{ranker}
\alias{resampstats}
\alias{traj.info}
\alias{traj.stats}
\alias{trajplot}
\alias{uberstats}
\alias{unioner}
\alias{unionpts}
\alias{vol.box}
%\alias{which.box}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{Undocumented Functions for sdtoolkit}
\description{
A listing of all the helper and undocumented functions in \pkg{sdtoolkit}, along with brief description of their functionality.  While some of these are useless except as part of larger functions, many may have use in post-discovery analysis of boxes, and the user may wish to explore their application.  
}
%\usage{
%
%}

\details{
The functions are briefly discussed below, along with attributions to code from Duong's original \pkg{prim} package, where appropriate.  

\itemize{
\item{beval}{\dQuote{Box Evaluation} - Calculates coverage and density statistics for an individual box.}
\item{boxconverter}{Converts a matrix-style box to a list-style box for use in \code{pbox}.}
\item{colptplot}{\dQuote{Colored Point Plot} - Function for plotting a scatterplot of the dataset given two specific dimensions to focus on, with high-value and low-value points distinguished via different fills and/or colors.}
\item{contourmkr}{A rather untransparent function that generates other boxes by removing dimensions from the boxes that populate a box trajectory.}
\item{csvboxes}{Writes out box definitions in format designed to be read in by CARs.}
\item{dimchecker}{\dQuote{Dimension Checker} - Small function to determine which ends of which dimensions have been restricted from their initial values.}
\item{dupcolchecker}{\dQuote{Duplicate Column Checker} - Called by \code{sd.start}, checks for whether columns in the potential input matrix are identical to other columns.}
%\item{find.box}
\item{filterpts}{Takes a dataset and a box, and returns the subset of points inside or outside the box.}
\item{find.traj}{Based on Duong's \code{find.box}, is called by \code{prim.traj}, uses \code{peel.one} and \code{paste.one} to generate a trajectory of boxes.}
\item{boxformat}{Formats box definition and statistics so they can be printed nicely.}
\item{in.box}{Unmodified from Duong, tests which points are inside a given box.}
\item{in.box.seq}{Unmodified from Duong, test which points are inside a box sequence.}
\item{lvout}{Finds the statistics associated with the boxes that result from dropping individual dimensions from a box.}
\item{nicecat}{An entirely helper function for automatically doing word wrap, used in dialogue-heavy functions in the R console, such as \code{sd.start} and \code{sdprim}.}
\item{nullprob}{Estimates p-values for the significance of dimension restrictions, under certain assumptions (which are likely not actually met).}
\item{olaps}{Takes the input data, output data and box sequence and returns the \code{olaps} attribute of a box sequence, a matrix which gives absolute coverage, and overlaps in box support and coverage.}
%\item{overlap.box}
%\item{overlap.box.seq}
\item{paste.one}{Essentially Duong's function - pasting one face onto a candidate box on the trajectory.}
\item{pbox}{Function to plot rectangular boxes based on the box definitions in one of several forms.}
\item{peel.one}{Very slightly modified from Duong's function of the same name, notably to call \code{pquantile} (below) rather than one of \R's built-in quantile functions.}
\item{pquantile}{A modified quantile function that better accounts for input vectors that have multiple repeated values.  }
%\item{prim.box}
%\item{prim.combine}
%\item{prim.hdr}
%\item{prim.one}
\item{prim.traj}{Second-most high function that is responsible selection of individual boxes.  The function \code{sdprim} is essentially a wrapper for this.  Based off of Duong's \code{prim.one}.}
\item{boxprint}{Prints boxes in an easy to read way, along with some of their statistics.}
\item{pvallister}{A wrapper of \code{nullprob}, calculates the quasi-p-values displayed along with dimension restrictions.}
\item{ranker}{Ranks the dimension restrictions according to their importance in raising the density of the box.}
\item{resampstats}{Resamples the original dataset multiple times to get an estimate of the variance of the statistics.}
\item{traj.info}{Get information on boxes in the trajectory.}
\item{traj.stats}{Formulate the trajectory statistics.}
\item{trajplot}{Plots a box trajectory, possibly with dimensions contours and dominated points.}
\item{uberstats}{Finds the ensemble statistics for a box sequence.}
\item{unioner}{Takes two box definitions (defined differently in a somewhat non-standard format) and returns the box that minimally encompasses both, in list format.}
\item{unionpts}{Finds the union of points contained within all boxes in a box sequence.}
\item{vol.box}{Duong's original code, used by \code{peel.one}.}
%\item{which.box}{USED??? (original duong}
}

}

%- maybe also 'usage' for other objects documented here.

%\references{ ~put references to the literature/web site here ~ }
\author{Benjamin P. Bryant, \email{bryant@prgs.edu}, with some code taken from Tarn Duong's \pkg{prim} package.}
%\note{ ~~further notes~~ 

% ~Make other sections like Warning with \section{Warning }{....} ~
%}
\seealso{\code{\link{sdprim}}, \pkg{prim}}
%\examples{
%}
\keyword{internal}
