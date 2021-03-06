#' Interactive view of spectrograms 
#' 
#' \code{manualoc} produces an interactive spectrographic view in which the start 
#' and end times of acoustic signals can be measured.
#' @usage manualoc(wl = 512, flim = c(0,12), seltime = 1, tdisp = NULL, reccomm =
#'   FALSE, wn = "hanning", title = TRUE, selcomm = FALSE, osci = FALSE, player =
#'   NULL, pal = reverse.gray.colors.2, path = NULL, flist = NULL, 
#'   fast.spec = FALSE, ext.window = TRUE, width = 15, height = 5)
#' @param wl A numeric vector of length 1 specifying the spectrogram window length. Default is 512.
#' @param flim A numeric vector of length 2 specifying the frequency limit (in kHz) of 
#'   the spectrogram, as in the function \code{\link[seewave]{spectro}}. 
#'   Default is c(0,12).
#' @param seltime A numeric vector of length 1 indicating the time interval in seconds at which 
#' the spectrograms are produced with higher resolution (ovlp = 70) and oscillograms (if osci = \code{TRUE}). 
#'  Default is 1 second.
#' @param tdisp A numeric vector of length 1 specifying the length in seconds of the total sound file to 
#' be displayed. Default is \code{NULL} which displays the full sound file.
#' @param reccomm Logical argument. If \code{TRUE} pops up a comment window at the end of each sound file.
#'   The comment needs to be quoted. Default is \code{FALSE}.
#' @param wn A character vector of length 1 specifying the window function (by default "hanning"). See function 
#' \code{\link[seewave]{ftwindow}} for more options.
#' @param title Logical argument. If \code{TRUE} the name of the sound file will be printed as the main 
#'   title of the spectrogram window. Default is \code{TRUE}
#' @param selcomm Logical argument. If \code{TRUE} pops up a comment window after each selection. The 
#'   comment is printed as a label on the selected unit. The comment must be quoted. Default is \code{FALSE}
#' @param osci Logical argument. If \code{TRUE} adds a oscillogram whenever the spectrograms are produced 
#'   with higher resolution (see seltime). Default is \code{FALSE}.
#' @param player Path to or name of a program capable of playing a wave file by 
#'   invocation from the command line. If under Windows and no player is given, 
#'   windows player will be chosen as the default. "vlc" works in Linux if vlc player is installed. 
#'   The external program must be closed before resuming analysis. Default is \code{NULL}.
#' @param pal A color palette function to be used to assign colors in the 
#'   plot, as in \code{\link[seewave]{spectro}}. Default is reverse.gray.colors.2. See Details.
#' @param path Character string containing the directory path where the sound files are located. 
#' If \code{NULL} (default) then the current working directory is used.
#' @param flist character vector or factor indicating the subset of files that will be analyzed. Ignored
#' if X is provided.
#' @param fast.spec Logical. If \code{TRUE} then image function is used internally to create spectrograms, which substantially 
#' increases performance (much faster), although some options become unavailable, as collevels, and sc (amplitude scale).
#' This option is indicated for signals with high background noise levels. Palette colors \code{\link[monitoR:specCols]{gray.1}}, \code{\link[monitoR:specCols]{gray.2}}, 
#' \code{\link[monitoR:specCols]{gray.3}}, \code{\link[monitoR:specCols]{topo.1}} and \code{\link[monitoR:specCols]{rainbow.1}} (which should be imported from the package monitoR) seem
#' to work better with 'fast' spectrograms. Palette colors \code{\link[monitoR:specCols]{gray.1}}, \code{\link[monitoR:specCols]{gray.2}}, 
#' \code{\link[monitoR:specCols]{gray.3}} offer 
#' decreasing darkness levels.
#' @param ext.window Logical. If \code{TRUE} then and external graphic window is used. Default 
#' dimensions can be set using the 'width' and 'height' arguments. Default is \code{TRUE}.
#' @param width Numeric of length 1 controlling the width of the external graphic window. Ignored
#' if \code{ext.window = FALSE}. Default is 15.
#' @param height Numeric of length 1 controlling the height of the external graphic window.
#' Ignored if \code{ext.window = FALSE}. Default is 5. 
#' @return .csv file saved in the working directory with start and end time of 
#'   selections.
#' @export
#' @name manualoc
#' @examples
#' \dontrun{
#' # save wav file examples
#' data(list = c("Phae.long1", "Phae.long2", "Phae.long3", "Phae.long4"))
#' writeWave(Phae.long1, file.path(tempdir(), "Phae.long1.wav"))
#' writeWave(Phae.long2, file.path(tempdir(), "Phae.long2.wav"))
#' writeWave(Phae.long3, file.path(tempdir(), "Phae.long3.wav"))
#' writeWave(Phae.long4, file.path(tempdir(), "Phae.long4.wav"))
#' 
#' manualoc(wl = 300, path = tempdir())
#' # need to use the buttoms to manipulate function
#' # check working directory for .csv file after stopping function
#' #check here:
#' tempdir()
#' }
#' @details This function may work very slowly with middle and large size sound files. We strongly suggest using
#'  other software tools (e.g. Raven, Avisoft) to create selection tables manually. 
#' 
#'   Users can zoom-in a specific sound file segment by clicking at the 
#'   start and end (left side and right side) of the segment. To select the
#'   start and end of a vocalization unit the users need to click at the end and
#'   then at the start (right side and left side) of the unit. In addition, 6 
#'   "buttons" are provided at the upper right side of the spectrogram that
#'   allow to display a full view of the spectrogram ("Full view"), go back to
#'   the previous view ("Previous view"), stop the analysis ("Stop"), go to the
#'   next sound file ("Next rec"), play the current view using external software 
#'   ("Play", see "player" argument), or delete the last manual selection in the
#'   current sound file ("Delete"). When a unit has been selected, the function 
#'   plots a red circle with the selection number in the middle point of the 
#'   selection in the spectrogram. It also plots vertical dotted lines at the 
#'   start and end of the selection. The circle and lines "disappear" when the 
#'   selection is deleted ("Delete" button). Only the last selection can be deleted. 
#'   
#'   The function produces a .csv file (manualoc_output.csv) with information about the .wav file name,
#'   selection number, start and end time, selection comment (selcomm), and
#'   sound file comment (reccomm). The file is saved in the working directory and
#'   is updated every time the user moves into the next sound file (Next rec
#'   "button") or stop the process (Stop "button"). When resuming the process
#'   (after "stop" and re-running the function in the same working directory),
#'   the function will keep the previous selections and will only pick up .wav
#'   files that are not present in the .csv file (not previously analyzed). When users 
#'   go to the next sound file (Next rec "button") without making any
#'   selection the file is still included in the .csv file, with NA's in the
#'   "end", "time" and "selec" field. 
#'   
#'   Windows length (wl) controls the temporal and frequency precision of the spectrogram. 
#'   A high "wl" value increases the frequency resolution but reduces the temporal resolution, and vice versa. Any
#'   color palette that comes with the seewave package can be used: temp.colors,
#'   reverse.gray.colors.1, reverse.gray.colors.2, reverse.heat.colors, reverse.terrain.colors,
#'   reverse.topo.colors, reverse.cm.colors, heat.colors, terrain.colors, topo.colors,
#'   cm.colors. The function is slow when working on files of length > 5min. In most cases other
#'   sound analysis software for manually selecting acoustic signals (e.g. Raven, Syrinx) should
#'   be preferred.
#'  
#' @seealso  \code{\link{seltailor}}
#'    
#' @author Marcelo Araya-Salas (\email{marcelo.araya@@ucr.ac.cr}) 
#last modification on jul-5-2016 (MAS)

manualoc <- function(wl = 512, flim = c(0,12), seltime = 1, tdisp = NULL, reccomm = FALSE, wn = "hanning", title = TRUE, 
                     selcomm = FALSE, osci = FALSE, player = NULL, pal = reverse.gray.colors.2,
                     path = NULL, flist = NULL, fast.spec = FALSE, ext.window = TRUE, width = 15, height = 5)
{
 
  #### set arguments from options
  # get function arguments
  argms <- methods::formalArgs(manualoc)
  
  # get warbleR options
  opt.argms <- if(!is.null(getOption("warbleR"))) getOption("warbleR") else SILLYNAME <- 0
  
  # rename path for sound files
  names(opt.argms)[names(opt.argms) == "wav.path"] <- "path"
  
  # remove options not as default in call and not in function arguments
  opt.argms <- opt.argms[!sapply(opt.argms, is.null) & names(opt.argms) %in% argms]
  
  # get arguments set in the call
  call.argms <- as.list(base::match.call())[-1]
  
  # remove arguments in options that are in call
  opt.argms <- opt.argms[!names(opt.argms) %in% names(call.argms)]
  
  # set options left
  if (length(opt.argms) > 0)
    for (q in 1:length(opt.argms))
      assign(names(opt.argms)[q], opt.argms[[q]])
  
  #check path to working directory
  if (is.null(path)) path <- getwd() else 
    if (!dir.exists(path)) 
      stop("'path' provided does not exist") else
        path <- normalizePath(path)
  
  options(show.error.messages = TRUE) 
  files <- list.files(path = path, pattern = "\\.wav$", ignore.case = TRUE) #list .wav files in working director
  if (length(files) == 0) stop("no .wav files in working directory")
  
  #if flist is not character vector
  if (!is.null(flist) & any(!is.character(flist), !is.vector(flist))) stop("'flist' must be a character vector") 
  
  #filter based on flist
  if (!is.null(flist)) files <- files[files %in% flist]
  if (length(files) == 0) stop("Files in 'flist' not in working directory")
  
  if (!file.exists(file.path(path, "manualoc_output.csv")))
  {results <- data.frame(matrix(nrow = 0, ncol = 6))
   colnames(results) <- c("sound.files", "selec", "start", "end", "sel.comment", "rec.comment")
   write.csv(results, file.path(path, "manualoc_output.csv"), row.names = FALSE)} else
   {if (nrow(read.csv(file.path(path, "manualoc_output.csv"))) == 0)
   {results <- data.frame(matrix(nrow = 0, ncol = 6))
    colnames(results) <- c("sound.files", "selec", "start", "end", "sel.comment", "rec.comment")} else
   {results <- read.csv(file.path(path, "manualoc_output.csv"))  
    files <- setdiff(files, results$sound.files)}} 
  
  if (length(files) == 0) { stop("all .wav files in working directory have been analyzed")}
  wavs = 0
  
  #set external window function
  if (any(Sys.info()[1] == c("Linux", "Windows"))) extwin <- grDevices::X11 else extwin <- grDevices::quartz
  
  #start external graphic device
  if (ext.window)  extwin(width = width, height = height)
  
  #this first loop runs over files
  repeat{
    wavs = wavs + 1 # for selecting .wav files
    rec.comment <- NA
    sel.comment <- NA
    ovlp <- 0 # for spectro display
    prev <- NULL #for going to previous view
    recs <- vector() #store results
    rec <- warbleR::read_wave(X = files[wavs], path = path)
    if (title) main <- files[wavs] else main <- NULL
    f <- rec@samp.rate #for spectro display
    fl<- flim #in case flim its higher than can be due to sampling rate
    if (fl[2] > ceiling(f/2000) - 1) fl[2] <- ceiling(f/2000) - 1 
    len <- seewave::duration(rec) #for spectro display 
    if (!is.null(tdisp) && len > tdisp) len <- tdisp #to decide when to create hi resolution spectro
    tlim <- c(0, len) 
    start <- numeric() #save results
    end <- numeric() #save results
    prop <- 14.1 # for box size
    marg1 <- 15/prop # for box size
    marg2 <- marg1*prop/14.9 # for box size
    
    #this second run on a single file and breaks when clicking on stop or next
    repeat{
      
      #choose spectrogram "resolution" based on seltime duration (see descrrption)
      if (tlim[2] - tlim[1] < seltime) seqs <- seq(-40, 0, 0.5) else  seqs <- seq(-50, 0, 10)   
      if (tlim[2] - tlim[1] < seltime) ovlp <- 70 else ovlp <- 0
      if (tlim[2] - tlim[1] < seltime && osci) osc <- T else  osc <- F
      
      #set an undivided window
      if (mean(par("mfrow")) != 1) par(mfrow = c(1, 1))
      
      #create spectrogram
      spectro_wrblr_int(rec, f = f, wl = wl, ovlp = ovlp, wn = wn, collevels = seqs, heights = c(3, 2), osc = osc, palette =  pal, 
              main = main, tlim = tlim, axisX = TRUE, grid = FALSE, collab = "black", alab = "", fftw = TRUE, 
              flim = fl, scale = FALSE, axisY = TRUE, cexlab = 1, flab = "Frequency (kHz)", tlab = "Time (s)", fast.spec = fast.spec)
      
      #add the circle and lines of selections on spectrogram
      if (length(start) > 0)
      {points(apply(data.frame(start, end), 1, mean),
              rep(((fl[2] - fl[1])/2) + fl[1], length(start)), col = "#E37222", cex = 4, pch = 20)
       abline(v = c(start, end), lty = 3, col = "#E37222", lwd = 0.8)
       text(apply(data.frame(start, end), 1, mean),
            rep(((fl[2] - fl[1])/2) + fl[1], length(start)), labels = c((1:length(start) + 
                                                                           nrow(results[results$sound.files == files[wavs], ]))))
       if (selcomm)  text(apply(data.frame(start, end), 1, mean), 
                         rep(((fl[2] - fl[1])/2) + fl[1], length(start)) + (((fl[2] - fl[1])/2) + fl[1])/6, labels = sel.comment)}
      
      #full view button (buttons are just boxes, each one has a box and a text)
      polygon(c((tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg1, 
                (tlim[2] - tlim[1])/marg2, (tlim[2] - tlim[1])/marg2) + tlim[1], c((fl[2] - fl[1])/marg1, 
                                                                                   (fl[2] - fl[1])/marg2, (fl[2] - fl[1])/marg2, 
                                                                                   (fl[2] - fl[1])/marg1) + fl[1], col = adjustcolor("#07889B", alpha.f = 0.15), border = "#07889B")
      
      text(((((tlim[2] - tlim[1])/marg1) + ((tlim[2] - tlim[1])/marg2))/2) + tlim[1], 
           ((((fl[2] - fl[1])/marg1) + ((fl[2] - fl[1])/marg2))/2) + fl[1], "Full view", 
           cex = 0.6, font = 2)
      
      #Previous view button
      polygon(c((tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg2, 
                (tlim[2] - tlim[1])/marg2) + tlim[1], c((fl[2] - fl[1])/marg1, (fl[2] - fl[1])/marg2, (fl[2] - fl[1])/marg2, 
                                                        (fl[2] - fl[1])/marg1) - ((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1) + fl[1], 
              col = adjustcolor("#07889B", alpha.f = 0.15), border = "#07889B")      
      text(((((tlim[2] - tlim[1])/marg1) + ((tlim[2] - tlim[1])/marg2))/2) + tlim[1],
           ((((fl[2] - fl[1])/marg1) + ((fl[2] - fl[1])/marg2))/2) + fl[1] - ((fl[2] - fl[1])/
                                                                                marg2 - (fl[2] - fl[1])/marg1), "Previous view", cex = 0.5, font = 2)
      
      #Stop button
      polygon(c((tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg2, 
                (tlim[2] - tlim[1])/marg2) + tlim[1], c((fl[2] - fl[1])/marg1, (fl[2] - fl[1])/marg2, (fl[2] - fl[1])/marg2, 
                                                        (fl[2] - fl[1])/marg1) - (2*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1], 
              col = adjustcolor("#07889B", alpha.f = 0.15), border = "#07889B")      
      
      text(((((tlim[2] - tlim[1])/marg1) + ((tlim[2] - tlim[1])/marg2))/2) + tlim[1], 
           ((((fl[2] - fl[1])/marg1) + ((fl[2] - fl[1])/marg2))/2) + fl[1] - (2*((fl[2] - fl[1])/
                                                                                   marg2 - (fl[2] - fl[1])/marg1)), "Stop", cex = 0.6, font = 2)
      
      #next rec button
      polygon(c((tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg2,
                (tlim[2] - tlim[1])/marg2) + tlim[1], c((fl[2] - fl[1])/marg1, (fl[2] - fl[1])/marg2, (fl[2] - fl[1])/marg2, 
                                                        (fl[2] - fl[1])/marg1) - (3*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1], 
              col = adjustcolor("#07889B", alpha.f = 0.15), border = "#07889B")
      
      text(((((tlim[2] - tlim[1])/marg1) + ((tlim[2] - tlim[1])/marg2))/2) + tlim[1], 
           ((((fl[2] - fl[1])/marg1) + ((fl[2] - fl[1])/marg2))/2) + fl[1] - (3*((fl[2] - fl[1])/
                                                                                   marg2 - (fl[2] - fl[1])/marg1)), "Next rec", cex = 0.6, font = 2)
      
      #play buttom
      polygon(c((tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg2, 
                (tlim[2] - tlim[1])/marg2) + tlim[1], c((fl[2] - fl[1])/marg1, (fl[2] - fl[1])/marg2, (fl[2] - fl[1])/marg2, 
                                                        (fl[2] - fl[1])/marg1) - (4*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1], 
              col = adjustcolor("#07889B", alpha.f = 0.15), border = "#07889B")
      
      text(((((tlim[2] - tlim[1])/marg1) + ((tlim[2] - tlim[1])/marg2))/2) + tlim[1], 
           ((((fl[2] - fl[1])/marg1) + ((fl[2] - fl[1])/marg2))/2) + fl[1] - (4*((fl[2] - fl[1])/
                                                                                   marg2 - (fl[2] - fl[1])/marg1)), "Play", cex = 0.5, font = 2)
      
      #delete selection
      polygon(c((tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg1, (tlim[2] - tlim[1])/marg2, 
                (tlim[2] - tlim[1])/marg2) + tlim[1], c((fl[2] - fl[1])/marg1, (fl[2] - fl[1])/marg2, (fl[2] - fl[1])/marg2, 
                                                        (fl[2] - fl[1])/marg1) - (5*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1], 
              col = adjustcolor("#07889B", alpha.f = 0.15), border = "#07889B")
      
      text(((((tlim[2] - tlim[1])/marg1) + ((tlim[2] - tlim[1])/marg2))/2) + tlim[1], 
           ((((fl[2] - fl[1])/marg1) + ((fl[2] - fl[1])/marg2))/2) + fl[1] - (5*((fl[2] - fl[1])/
                                                                                   marg2 - (fl[2] - fl[1])/marg1)), "Delete", cex = 0.5, font = 2)
      
      #ask users to select what to do next (2 clicks)
      xy <- locator(n = 2, type = "n")
      
      #if selected is lower than 0 make it 
      xy$x[xy$x<0] <- 0  
      
      # the following code chuncks have the following structure: if click on this box or do this 
      #or if click in this way (left-right or right-left) do this  
      
      #measure/play/delete selection
      #this is the most complicated. It keeps running if the users make a selection (right-left),
      #double click on delete or double click on play
      while(any(xy$x[1] > xy$x[2] & xy$x < (((tlim[2] - tlim[1])/marg1) + tlim[1]),  
                all(xy$x > (((tlim[2] - tlim[1])/marg1) + tlim[1])) & all(xy$x < (((tlim[2] - tlim[1])/marg2) + tlim[1])) & 
                  all(xy$y < (fl[2] - fl[1])/marg2 - (4*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]) & 
                  all(xy$y > (fl[2] - fl[1])/marg1 - (4*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]),
                all(xy$x > (((tlim[2] - tlim[1])/marg1) + tlim[1])) & 
                  all(xy$x < (((tlim[2] - tlim[1])/marg2) + tlim[1])) & 
                  all(xy$y < (fl[2] - fl[1])/marg2 - (5*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]) & 
                  all(xy$y > (fl[2] - fl[1])/marg1 - (5*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1])))
      {if (all(xy$x > (((tlim[2] - tlim[1])/marg1) + tlim[1])) & 
            all(xy$x < (((tlim[2] - tlim[1])/marg2) + tlim[1])) &
            all(xy$y < (fl[2] - fl[1])/marg2 - (4*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]) & 
            all(xy$y > (fl[2] - fl[1])/marg1 - (4*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]) & !is.null(player))
       tuneR::play(cutw(rec, from = tlim[1], to = tlim[2], output = "Wave"), player = player)
       else {if (all(xy$x > (((tlim[2] - tlim[1])/marg1) + tlim[1])) & all(xy$x < (((tlim[2] - tlim[1])/marg2) + 
                                                                                     tlim[1])) & #if click on delete
                   all(xy$y < (fl[2] - fl[1])/marg2 - (5*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]) &
                   all(xy$y > (fl[2] - fl[1])/marg1 - (5*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]) &
                   length(start) > 0) {points(mean(c(start[length(start)], end[length(end)])), 
                                              ((fl[2] - fl[1])/2) + fl[1], col = "white", cex = 4.2, pch = 20)
                                       abline(v = c(start[length(start)], end[length(end)]), lty = 1, col = "white", lwd = 2.3)
                                       if (selcomm) {text(mean(c(start[length(start)], end[length(end)])), 
                                                         ((fl[2] - fl[1])/2) + fl[1] + (((fl[2] - fl[1])/2) + fl[1])/6, labels = sel.comment[length(start)], col = "white")
                                                    if (length(sel.comment) == 1)  sel.comment <- character() else sel.comment <- sel.comment[1:(length(sel.comment) - 1)]}
                                       if (length(start) == 1) start <- numeric() else start <- start[1:(length(start) - 1)]
                                       if (length(end) == 1) end <- numeric() else end <- end[1:(length(end) - 1)]
      } else {start[length(start) + 1] <- xy$x[2]
              end[length(end) + 1] <- xy$x[1]
              points(apply(data.frame(start, end), 1, mean), 
                     rep(((fl[2] - fl[1])/2) + fl[1], length(start)), col = "#E37222", cex = 4, pch = 20)
              abline(v = c(start, end), lty = 3, col = "#E37222", lwd = 0.8)
              text(apply(data.frame(start, end), 1, mean), 
                   rep(((fl[2] - fl[1])/2) + fl[1], length(start)), labels = c((1:length(start) + 
                                                                                  nrow(results[results$sound.files == files[wavs], ]))))
              if (selcomm)  {sel.comment[length(start)] <- edit((sel.comment[length(start)]))         
                            text(apply(data.frame(start, end), 1, mean), 
                                 rep(((fl[2] - fl[1])/2) + fl[1], length(start)) + (((fl[2] - fl[1])/2) + fl[1])/6, labels = sel.comment
                            )} else sel.comment <- ""        
      }}
      xy <- locator(n = 2, type = "n")}
      
      #if selected is lower than 0 make it 
      xy$x[xy$x<0] <- 0  
      
      #this allows to go the previous view
      prev1 <- tlim
      
      #stop
      if (all(xy$x > (((tlim[2] - tlim[1])/marg1) + tlim[1])) && 
           all(xy$x < (((tlim[2] - tlim[1])/marg2) + tlim[1])) && 
           all(xy$y < (fl[2] - fl[1])/marg2 - (2*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1])
         && all(xy$y > (fl[2] - fl[1])/marg1 - (2*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]))
      {if (length(start) > 0) {    if (reccomm) rec.comment <- edit((rec.comment)) else rec.comment <- ""
                                  selec <- 1:length(start)
                                  results <- rbind(results, data.frame(sound.files = files[wavs], selec, start, end, sel.comment, rec.comment))
                                  results$sound.files <- as.character(results$sound.files)
                                  write.csv(results, file.path(path, "manualoc_output.csv"), row.names = FALSE)
                                  dev.off()
                                  }
       
       stop("Stopped by user")}
      
      #next rec
      if (all(xy$x > (((tlim[2] - tlim[1])/marg1) + tlim[1])) && 
           all(xy$x < (((tlim[2] - tlim[1])/marg2) + tlim[1])) && 
           all(xy$y < (fl[2] - fl[1])/marg2 - (3*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1])
         && all(xy$y > (fl[2] - fl[1])/marg1 - (3*((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1)) + fl[1]))
      {if (length(setdiff(files, unique(results$sound.files))) == 0)
      {try(dev.off(), silent = TRUE)
       cat("all .wav files in working directory have been analyzed")
       options( show.error.messages = FALSE)
       stop("")}
      if (reccomm) rec.comment <- edit(rec.comment) else rec.comment <- ""   
      if (length(start) > 0) { selec <- 1:length(start)
                              results <- rbind(results, data.frame(sound.files = files[wavs], selec, start, end, sel.comment, rec.comment))
                              results$sound.files <- as.character(results$sound.files)
                              write.csv(results, file.path(path, "manualoc_output.csv"), row.names = FALSE)} else {
                                results <- rbind(results, data.frame(sound.files = files[wavs], selec = NA, start = NA,
                                                                     end = NA, sel.comment = NA, rec.comment))
                                results$sound.files <- as.character(results$sound.files)
                                write.csv(results, file.path(path, "manualoc_output.csv"), row.names = FALSE)}    
      break}
      
      #previous view
      if (all(xy$x > (((tlim[2] - tlim[1])/marg1) + tlim[1])) && 
           all(xy$x < (((tlim[2] - tlim[1])/marg2) + tlim[1])) && 
           all(xy$y < (fl[2] - fl[1])/marg2 - ((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1) + fl[1])
         && all(xy$y > (fl[2] - fl[1])/marg1 - ((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1) + fl[1]))
      {if (is.null(prev)) tlim <- tlim
       if (!is.null(prev)) tlim <- prev}
      
      #full view
      if (all(xy$x > (((tlim[2] - tlim[1])/marg1) + tlim[1])) && all(xy$x < (((tlim[2] - tlim[1])/marg2) + tlim[1])) && 
           all(xy$y < ((fl[2] - fl[1])/marg2) + fl[1]) && all(xy$y > ((fl[2] - fl[1])/marg1) + fl[1]))
        tlim <- c(0.1, len - 0.1)
      
      #Zoom in
      if (all(xy$y < (fl[2] - fl[1])/marg1 - ((fl[2] - fl[1])/marg2 - (fl[2] - fl[1])/marg1) + fl[1]) && 
           xy$x[1] < xy$x[2])
        tlim <- c(xy$x[1], xy$x[2])
      
      if (abs(xy$x[2] - xy$x[1]) < abs(prev1[1] - prev1[2]) && xy$x[1] < xy$x[2]) prev <- prev1
      if (abs(xy$x[2] - xy$x[1]) > abs(prev1[1] - prev1[2]) && xy$x[1] < xy$x[2]) prev <- xy$x[order(xy$x)]
      
      if (abs(tlim[1] - tlim[2]) < 0.01) {tlim <- c(0.1, len - 0.1)}
      # dev.off()
      }
    
    if (!file.exists(file.path(path, files[wavs + 1])))
    {try(dev.off(), silent = TRUE)
     cat("This was the last sound file")
     break}
  }
  
    }


##############################################################################################################
#' alternative name for \code{\link{manualoc}}
#'
#' @keywords internal
#' @details see \code{\link{manualoc}} for documentation. \code{\link{manualoc}} will be deprecated in future versions.
#' @export

manual_loc <- manualoc
