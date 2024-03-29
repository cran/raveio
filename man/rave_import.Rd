% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rave-import.R
\name{rave_import}
\alias{rave_import}
\title{Import data into 'rave' projects}
\usage{
rave_import(
  project_name,
  subject_code,
  blocks,
  electrodes,
  format,
  sample_rate,
  conversion = NA,
  data_type = "LFP",
  task_runs = NULL,
  add = FALSE,
  ...
)
}
\arguments{
\item{project_name}{project name, for 'rave' native structure, this can be
any character; for 'BIDS' format, this must be consistent with 'BIDS'
project name. For subjects with multiple tasks, see Section "'RAVE' Project"}

\item{subject_code}{subject code in character. For 'rave' native structure,
this is a folder name under raw directory. For 'BIDS', this is subject
label without \code{"sub-"} prefix}

\item{blocks}{characters, for 'rave' native format, this is the folder names
subject directory; for 'BIDS', this is session name with \code{"ses-"}.
Section "Block vs. Session" for different meaning of "blocks" in 'rave'
and 'BIDS'}

\item{electrodes}{integers electrode numbers}

\item{format}{integer from 1 to 6, or character. For characters, you can get
options by running \code{names(IMPORT_FORMATS)}}

\item{sample_rate}{sample frequency, must be positive}

\item{conversion}{physical unit conversion, choices are \code{NA},
\code{V}, \code{mV}, \code{uV}}

\item{data_type}{electrode signal type; see \code{\link{SIGNAL_TYPES}}}

\item{task_runs}{for 'BIDS' formats only, see Section "Block vs. Session"}

\item{add}{whether to add electrodes. If set to true, then only new
electrodes are allowed to be imported, blocks will be ignored and trying to
import electrodes that have been imported will still result in error.}

\item{...}{other parameters}
}
\value{
None
}
\description{
Import files with predefined structures. Supported file
formats include 'Matlab', 'HDF5', 'EDF(+)', 'BrainVision'
(\code{'.eeg/.dat/.vhdr'}). Supported file structures include 'rave' native
structure and 'BIDS' (very limited) format. Please see
\url{https://openwetware.org/wiki/RAVE:ravepreprocess} for tutorials.
}
\section{'RAVE' Project}{

A 'rave' project can be very flexible. A project can refer to a task, a
research objective, or "arbitrarily" as long as you find common research
interests among subjects. One subject can appear in multiple projects with
different blocks, hence \code{project_name} should be
objective-based. There is no concept of "project" in 'rave' raw directory.
When importing data, you choose subset of blocks from subjects forming
a project.

When importing 'BIDS' data into 'rave', \code{project_name} must be
consistent with 'BIDS' project name as a compromise. Once imported,
you may change the project folder name in imported rave data
directory to other names. Because once raw traces are imported,
'rave' data will become self-contained
and 'BIDS' data are no longer required for analysis.
This naming inconsistency will also be ignored.
}

\section{Block vs. Session}{

'rave' and 'BIDS' have different definitions for a "chunk" of signals.
In 'rave', we use "block". it means
combination of session (days), task, and run, i.e. a block of continuous
signals captured. Raw data files are supposed to be stored in file
hierarchy of \code{<raw-root>/<subject_code>/<block>/<datafiles>}.
In 'BIDS', sessions, tasks, and runs are separated, and only session names
are indicated under subject folder. Because some previous compatibility
issues, argument \code{'block'} refers to direct folder names under
subject directories.
This means when importing data from 'BIDS' format, \code{block} argument
needs to be session names to comply with \code{'subject/block'} structure,
and there is an additional mandatory argument \code{task_runs}
especially designed for 'BIDS' format.

For 'rave' native raw data format, \code{block} will be as-is once imported.
\cr
For 'BIDS' format, \code{task_runs} will be treated as blocks once imported.
}

\section{File Formats}{

Following file structure. Here use project \code{"demo"} and subject
\code{"YAB"} and block \code{"008")}, electrode \code{14} as an example.
\describe{
\item{\code{format=1}, or \code{".mat/.h5 file per electrode per block"}}{
folder \code{<raw>/YAB/008} contains 'Matlab' or 'HDF5' files per electrode.
Data file name should look like \code{"xxx_14.mat"}}
\item{\code{format=2}, or \code{"Single .mat/.h5 file per block"}}{
\code{<raw>/YAB/008} contains only one 'Matlab' or 'HDF5' file. Data within
the file should be a 2-dimensional matrix, where the column 14 is
signal recorded from electrode 14}
\item{\code{format=3}, or \code{"Single EDF(+) file per block"}}{
\code{<raw>/YAB/008} contains only one \code{'edf'} file}
\item{\code{format=4}, or \code{
"Single BrainVision file (.vhdr+.eeg, .vhdr+.dat) per block"}}{
\code{<raw>/YAB/008} contains only one \code{'vhdr'} file, and
the data file must be inferred from the header file
}
\item{\code{format=5}, or \code{"BIDS & EDF(+)"}}{
\code{<bids>/demo/sub-YAB/ses-008/} must contains \code{*_electrodes.tsv},
each run must have channel file. The channel files and electrode file
must be consistent in names.
\cr
Argument \code{task_runs} is mandatory, characters, combination of session,
task name, and run number. For example, a task header file in BIDS with name
\code{'sub-YAB_ses-008_task-visual_run-01_ieeg.edf'} has \code{task_runs}
name as \code{'008-visual-01'}, where the first \code{'008'} refers
to session, \code{'visual'} is task name, and the second \code{'01'} is
run number.
}
\item{\code{format=6}, or \code{
"BIDS & BrainVision (.vhdr+.eeg, .vhdr+.dat)"}}{
Same as previous format \code{"BIDS & EDF(+)"}, but data files have
'BrainVision' formats.
}
}
}

