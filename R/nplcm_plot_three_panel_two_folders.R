#' Plot three-panel figures for nested partially-latent model results (two folders)
#'
#' Visualize the model outputs for communicating how does data inform final
#' etiology. Current code only works for single etiologies. Multiple etiology
#' has not been coded, because we need special handling of pathogen ordering.
#' Also, because multiple etiology has a different formula for model-based observed
#' rate. 
#' DN: 1. current implementation: nplcm, BrS and SS.
#' "Jfull" here is not the same as in other functions: it refers to the number of
#' pathogens even if there are pathogens with only silver-standard data;
#' in other functions, "Jfull" refers to the number of pathogens that have BrS data.
#' 2. Missing data for BrS or SS are dropped when calculating observed measurement
#' prevalences
#'
#' @param DIR_NPLCM1 File path 1 to the folder containing posterior samples
#' @param DIR_NPLCM2 File path 2 to the folder containing posterior samples
#' @param DIR_MEAS_PANEL The file path that will appear measurement panels;
#' Default is the second file path, \code{DIR_NPLCM2}.
#' @param index_for_order The index of the list to be used for 
#' ordering the pathogens. Because each model output might give
#' different ordering of pathogens (based on posterior mean).
#' @param SS_upperlimit The upper limit of horizontal bar for the silver-standard
#' subpanel (the middle panel). The default value is .25.
#'
#' @param eti_upperlimit The upper limit of horizontal bar for the etiology
#' posterior subpanel (the rightmost panel). The default value is .4
#' @param X covariate values; default is \code{NULL}. Current use of this function
#' does not need X.
#' 
#' @importFrom coda read.coda
#' @importFrom binom binom.confint
#' @return A figure with two or three columns
#'
#' @export
nplcm_plot_three_panel_two_folders <- function(DIR_NPLCM1,DIR_NPLCM2,
                                               DIR_MEAS_PANEL = DIR_NPLCM2,
                                               index_for_order,
                                               SS_upperlimit=1,
                                               eti_upperlimit=1,
                                               X=NULL){#BEGIN function
    
  model_options_list <- list()
  clean_options_list <- list()
  res_nplcm_list     <- list()
  bugs.dat_list      <- list()
  count <- 0
  
  DIR_vec <- c(DIR_NPLCM1,DIR_NPLCM2)
  
  for (DIR_NPLCM in DIR_vec){
      count <- count +1
      # read NPLCM outputs:
      out           <- nplcm_read_folder(DIR_NPLCM)
      # organize ouputs:
      Mobs          <- out$Mobs
      Y             <- out$Y
      model_options <- out$model_options
      clean_options <- out$clean_options
      res_nplcm     <- out$res_nplcm
      bugs.dat      <- out$bugs.dat
      
      model_options_list[[count]] <- model_options
      clean_options_list[[count]] <- clean_options
      res_nplcm_list[[count]]     <- res_nplcm
      bugs.dat_list[[count]]      <- bugs.dat
      
      rm(out)
  }
  
  # which folder to put as measurement summary:
  which_meas <- which(DIR_vec == DIR_MEAS_PANEL)
  # Determine which three-panel plot to draw:
  parsing <- assign_model(Mobs,Y,X,model_options_list[[which_meas]])
  # X not needed in the three-panel plot, but because 'assign_model' was designed
  # to distinguish models even with X, so we have to stick to the useage of 
  # assign_model.
  
  if (!any(unlist(parsing$reg))){
    # if no stratification or regression:
    if (parsing$measurement$quality=="BrS+SS"){
      if (!parsing$measurement$SSonly){
        if (!parsing$measurement$nest){
          print("== BrS+SS; no SSonly; subclass number: K = 1. ==")
        }else{
          print("== BrS+SS; no SSonly; subclass number: K > 1. ==")
        }
        #
        # Plot - put layout in place for three panels:
        #
        layout(matrix(c(1,2,3),1,3,byrow = TRUE),
               widths=c(3,2,3),heights=c(8))
        
        # BrS panel:
        nplcm_plot_BrS_panel(Mobs$MBS,model_options_list[[which_meas]],
                             clean_options_list[[which_meas]],
                             res_nplcm_list[[which_meas]],
                             bugs.dat_list[[which_meas]],
                             top_BrS = 1.3,prior_shape = "interval")
        # SS panel:
        nplcm_plot_SS_panel(Mobs$MSS,model_options_list[[which_meas]],
                            clean_options_list[[which_meas]],
                            res_nplcm_list[[which_meas]],
                            bugs.dat,top_SS = SS_upperlimit)
        # Etiology panel:
        nplcm_plot_pie_panel_two_folders(model_options_list,
                                         res_nplcm_list,
                                         bugs.dat_list,
                                        index_for_order = which_meas,
                             top_pie = eti_upperlimit)
        
      } else{
        if (!parsing$measurement$nest){
          stop("== BrS+SS; SSonly; subclass number: K = 1: not done.  ==")
          
        }else{
          stop("== BrS+SS; SSonly; subclass number: K > 1: not done.  ==")
        }
      }
    }else if (parsing$measurement$quality=="BrS"){
      if (!parsing$measurement$SSonly){
        if (!parsing$measurement$nest){
          stop("== BrS; no SSonly; subclass number: K = 1: not done.  ==")
        }else{
          stop("== BrS; no SSonly; subclass number: K > 1: not done.  ==")
        }
      }
    }
  } else{
    stop("== Three panel plot not implemented for stratification or regression
         settings. Please check back later for updates. Thanks. ==")
  }
  
}# END function
