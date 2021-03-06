% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fastqc.R
\name{fastqc}
\alias{fastqc}
\title{A function to handle a docker containier executing fastqc}
\usage{
fastqc(input.folder, reads = 0)
}
\arguments{
\item{input.folder, }{a character string indicating the folder where input data are located and where output will be written}

\item{reads, }{integer value indicating the number of reads to be evaluated in each fastq file. The default value allows user to pass all the file reads.}
}
\description{
This function executes a fedora docker that produces as output FASTQCstdin_fastqc.html and stdin_fastqc.zip files
}
\examples{
\dontrun{
    fastqc("fastq_folder")
}

}
\author{
Marco Beccuti, marco.beccuti [at] unito [dot] it, University of Torino
}
