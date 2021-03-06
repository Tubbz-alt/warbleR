% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/move.imgs.R
\name{move.imgs}
\alias{move.imgs}
\title{Move/copy image files between directories}
\usage{
move.imgs(from = NULL, to = NULL, it = "all", cut = TRUE, 
overwrite = FALSE, create.folder = TRUE, folder.name = "image_files", 
parallel = 1, pb = TRUE)
}
\arguments{
\item{from}{Directory path where image files to be copied are found. 
If \code{NULL} (default) then the current working directory is used.}

\item{to}{Directory path where image files will be copied to.}

\item{it}{A character vector of length 1 giving the image type to be used. "all",
"tiff", "jpeg" and "pdf" are admitted ("all" includes all the rest). Default is "all".}

\item{cut}{Logical. Determines if files are removed from the original location after
being copied (cut) or not (just copied). Default is \code{TRUE}.}

\item{overwrite}{Logical. Determines if files that already exist in the destination directory 
should be overwritten. Default is \code{FALSE}.}

\item{create.folder}{Logical. Determines if files are moved to a new folder (which is named with the
"folder.name" argument). Ignored if 'to' is provided. Default is \code{TRUE}.}

\item{folder.name}{Character string with the name of the new folder where the files will be 
copied to. Ignored if 'to' is provided. Default is \code{"image_files"}.}

\item{parallel}{Numeric. Controls whether parallel computing is applied.
It specifies the number of cores to be used. Default is 1 (i.e. no parallel computing).}

\item{pb}{Logical argument to control progress bar. Default is \code{TRUE}.}
}
\description{
\code{move.imgs} moves/copies image files created by \code{\link{warbleR}} between 
directories (folders).
}
\details{
This function aims to simplify the manipulation of the image files generated by many 
of the \code{\link{warbleR}} function. It copies/cuts files between directories.
}
\examples{
{
#load data
data("Cryp.soui")
writeWave(Cryp.soui, file.path(tempdir(), "Cryp.soui.wav")) #save sound files 

#autodetec location of signals
ad <- autodetec(threshold = 6, bp = c(1, 3), mindur = 1.2,
maxdur = 3, ssmooth = 600, wl = 300, flist = "Cryp.soui.wav", path = tempdir())

#track dominant frequency graphs with freq reange detection
trackfreqs(X = ad[!is.na(ad$start),], flim = c(0, 5), ovlp = 90, it = "tiff",
bp = c(1, 3), contour = "df", wl = 300, frange = TRUE, path = tempdir())

# create folder to move image files
dir.create(file.path(tempdir(), "imgs"))

#copy files
move.imgs(cut = FALSE, from = tempdir(), to = file.path(tempdir(), "imgs"))

# cut files
move.imgs(cut = TRUE, from = tempdir(), 
to = file.path(tempdir(), "imgs"), overwrite = TRUE)

# Check this folder
tempdir()
}

}
\references{
{
Araya-Salas, M., & Smith-Vidaurre, G. (2017). warbleR: An R package to streamline analysis of animal acoustic signals. Methods in Ecology and Evolution, 8(2), 184-191.
}
}
\seealso{
\code{\link{filtersels}}

Other data manipulation: 
\code{\link{open_wd}()},
\code{\link{split_wavs}()}
}
\author{
Marcelo Araya-Salas (\email{marcelo.araya@ucr.ac.cr})
}
\concept{data manipulation}
