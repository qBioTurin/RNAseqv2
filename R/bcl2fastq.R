#' @title Generating running bcl2fastq
#' @description This function executes the Illumina bcl2fastq program
#' @param samplesheet, a character string indicating the Illumina folder where the Samplesheet.csv is located.
#' @param output.folder, a character string indicating the fastq output folder.
#' @param threadBCL, a number indicating the number of threads to be used for loading BCL data
#' @param threadWritingFastq, a number indicating the number of threads to be used for writing FASTQ data
#'  @param threadDem, a number indicating the number of threads to be used for for processing demultiplexed data
#'
#' @return Fastq files
#' @examples
#'\dontrun{
#'     #running rsemstar index for human
#'     demultiplexing("~/home/data/input","~/home/data/output")
#'
#' }
#' @export
bcl2fastq <- function(samplesheet,output.folder, threadBCL=1, threadWritingFastq=1, threadDem=6){

  home <- getwd()
  input.folder=dirname(samplesheet)

  if (!file.exists(samplesheet)){
    cat(paste("\nIt seems that the ",samplesheet, " file does not exist.\n"))
    return(1)
  }
  setwd(input.folder)

  #running time 1
  ptm <- proc.time()
  #running time 1

  #Test docker
  test <- dockerTest()
  if(!test){
      cat("\nERROR: Docker seems not to be installed in your system\n")
      system("echo 10 > ExitStatusFile 2>&1")
      setwd(home)
      return(10)
  }
  #Test docker

  #reading docker image names
  containers.file=paste(path.package(package="RNAseq2"),"/Containers/containersNames.txt",sep="/")
  containers.names=read.table(containers.file,header=T,stringsAsFactors = F)
  #reading docker image names

  #Running docker
  params <- paste("--cidfile ", input.folder,"/dockerID -v ", input.folder,":/input -v ",output.folder,":/output -d ", containers.names["bcl2fastq",1],"  bcl2fastq /input /output /input/",basename(samplesheet)," ",threadBCL," ",threadWritingFastq," ",threadDem, sep="")

  cat("\n\n************ Demultiplexing running ************\n\n")
  resultRun=dockerRun(params=params)

  if(resultRun==0){
    cat("\nDemultiplexing is finished\n")
  }
  #Running docker


  ptm <- proc.time() - ptm

  tmp.run <- NULL
  tmp.run[length(tmp.run)+1] <- paste("demultiplexing user run time mins ",ptm[1]/60, sep="")
  tmp.run[length(tmp.run)+1] <- paste("demultiplexing system run time mins ",ptm[2]/60, sep="")
  tmp.run[length(tmp.run)+1] <- paste("demultiplexing elapsed run time mins ",ptm[3]/60, sep="")
  writeLines(tmp.run, paste(input.folder,"time.info", sep="/"))


  #Storing ExitSatus
  system("echo 0 > ExitStatusFile 2>&1")

  setwd(home)
  }
