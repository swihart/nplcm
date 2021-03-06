% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/clean_perch_data.R
\name{clean_perch_data}
\alias{clean_perch_data}
\title{Clean PERCH data}
\usage{
clean_perch_data(clean_options)
}
\arguments{
\item{clean_options}{The list of options for cleaning PERCH data.
Its elements are defined as follows:
\itemize{
\item{\code{case_def}}{: variable name in raw data for case definition;}
\item{\code{case_def_val}}{: The value corresponding to cases;}
\item{\code{ctrl_def}}{: variable name in raw data for control definition;}
\item{\code{ctrl_def_val}}{: The value corresponding to controls;}
\item{\code{X_strat}}{: A vector of variable names for stratifying the data
to perform SEPARATE analyses;}
\item{\code{X_strat_val}}{: A list of actual values for \code{X_strat};}
\item{\code{pathogen_BrS_anyorder}}{: The vector of pathogen names (arbitrary
order) that have bronze-standard (BrS) measurments (cf. Wu et al. (2015) for
definitions and examplels of BrS, SS, and GS). It has to be a subset of
pathogens listed incategory information at the file path \code{PathCatDir}.}
\item{\code{pathogen_SSonly}}{: A vector of pathogens that only have SS data;}
\item{\code{X_extra}}{: A vector of variable names for regression purpose
or visualization purposes;}
\item{\code{X_order_obs}}{: A vector of variable names for ordering observations.
For example, it can include site names or enrollment dates. It has to be a
subset of X_extra;}
\item{\code{RawMeasDir}}{: The file path to the raw data;}
\item{\code{write_newSite}}{: Must be set to \code{TRUE} if the raw data is
changed;}
\item{\code{newSite_write_Dir}}{: The file path to a cleaned data set after
combining subsites within a site;}
\item{\code{MeasDir}}{: The file path to the cleaned data set, usually the
same as \code{newSite_write_Dir};}
\item{\code{PathCatDir}}{: The file path to the pathogen category information
(.csv). This list should be as complete as possible to display all pathogens
considered an actual analysis;}
\item{\code{allow_missing}}{: \code{TRUE} for allowing the program to use an
observation that has either BrS missing, or SS missing. Set it to \code{TRUE}
if we want to use the SS information from some cases who missed BrS
measurements. \code{TRUE} is equivalent to using all the subjects.}
}}
}
\value{
A List: \code{list(Mobs,Y,X,JSS,pathogen_MSS_ordered,pathogen_cat)}, or
with additional \code{JSSonly, pathogen_SSonly_cat} if silver-
standard only pathogens are supplied.
\itemize{
\item \code{Mobs} A list of bronze- (\code{MBS}), silver- (\code{MSS}),
and gold-standard (\code{MGS}, if available) measurements. Here if all
pathogens have BrS measures, MSS has the same number of columns as in MBS;
if some pathogens only have SS measures, then MSS will have extra columns;
\item \code{Y} 1 for case; 0 for control;
\item \code{X} Data frame of covariates for cases and controls. The covariate
names are specified in \code{X_extra};
\item \code{JSS} Number of pathogens having both silver- and bronze-standard
data;
\item \code{pathogen_MSS_ordered} Ordered vector of pathogen names. Pathogens
with both SS and BrS pathogens are ordered first and then those with only BrS
measurements. Note that for a pathogen name vector of arbitrary order
(\code{pathogen_BrS_anyorder}), this function just picks out those pathogens
with BrS+SS measures and puts them at the front. Other pathogens with only
BrS measures are not reordered. Pathogens with only silver-standard measures
are not included.
\item \code{pathogen_cat} Pathogen categories ordered according to
\code{pathogen_MSS_ordered}.
\item \code{JSSonly} Number of pathogens with only silver-standard measures;
\item \code{pathogen_SSonly_cat} Category of pathogens with only silver-standard
data.
}
This function does not re-order pathogens with only silver-standard data.
}
\description{
\code{clean_perch_data} transforms a raw data table (row for subject, column
for variable) into a list. It deletes cases having two positives
for BCX measures. To order cases and controls separately according to site
and enrollment date, we suggest put \code{c("newSITE","ENRLDATE")} in
\code{X_extra} and \code{X_order_obs} as defined below. The raw data must
have both BrS and SS measurements.
}

