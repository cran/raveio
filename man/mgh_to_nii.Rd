% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nifti.R
\name{mgh_to_nii}
\alias{mgh_to_nii}
\title{Convert 'FreeSurfer' \code{'mgh'} to 'Nifti'}
\usage{
mgh_to_nii(from, to)
}
\arguments{
\item{from}{path to 'FreeSurfer' \code{'mgh'} or \code{'mgz'} file}

\item{to}{path to 'Nifti' file, must ends with \code{'nii'} or \code{'nii.gz'}}
}
\value{
Nothing; the file will be created to path specified by \code{to}
}
\description{
Convert 'FreeSurfer' \code{'mgh'} to 'Nifti'
}
