% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/nplcm_plot_pie_panel.R
\name{nplcm_plot_pie_panel}
\alias{nplcm_plot_pie_panel}
\title{Plot etiology (pie) panel}
\usage{
nplcm_plot_pie_panel(model_options, res_nplcm, bugs.dat, top_pie = 1)
}
\arguments{
\item{model_options}{See \code{\link{nplcm}}}

\item{res_nplcm}{See \code{\link{nplcm_read_folder}}}

\item{bugs.dat}{Data input for the model fitting.}

\item{top_pie}{Numerical value to specify the rightmost limit
on the horizontal axis for the pie panel.}
}
\description{
Now only works for singleton etiologies.
}

