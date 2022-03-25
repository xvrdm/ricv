#' Create an interactive image comparator
#'
#' This function creates an interactive image comparator. See website of the
#' underlying project for examples: \url{https://image-compare-viewer.netlify.app/}
#'
#' @param img1 A path to an image file, or a ggplot object. This image will be placed to the left (i.e. 'before' image).
#' @param img2 A path to an image file, or a ggplot object. This image will be placed to the right (i.e. 'after' image).
#' @param options A list of image-compare-viewer options. See documentation for all options.
#' @param css A list of 3 optional attributes ('both', 'before' and 'after'), each containing CSS style attributes targeting the label corresponding to the used attribute name.
#' @param ggsave_dir If either img1 or img2 are ggplot2 objects, a name of a subfolder in which to save the images
#' @param ggsave_fnames Filenames to be used by ggplot2::ggsave when img1 or img2 are ggplot2 objects. Should be a vector of the same length as the number of ggplot2 objects. If null, filenames are created
#' @param ggsave_ext Extension to use for the ggplot2::ggsave, if filenames are not specified in ggsave_fnames
#' @param ... Further arguments to be passed to ggplot2::ggsave if img1 or img2 are ggplot objects
#'
#' @import htmlwidgets
#' @importFrom ggplot2 is.ggplot ggsave
#'
#' @export
ricv <- function(img1, img2, options = NULL, css = NULL, ggsave_dir = 'ricv_tmp', ggsave_fnames = NULL, ggsave_ext = '.png', ...) {

  print(options)
  print(css)
  valid_options <- new_Options(options)
  print(valid_options)

  # ggplot checking
  is_gg = c(img1 = ggplot2::is.ggplot(img1), img2 = ggplot2::is.ggplot(img2))
  if(any(is_gg)){

    if(!dir.exists(ggsave_dir))
      dir.create(ggsave_dir) # Create folder if necessary

    # Ideally this would use the chunk name in an Rmd context
    cat(valid_options$ggsave_ext)
    if(is.null(ggsave_fnames)){
      ggsave_fnames = replicate(2,
                tempfile(
                  pattern = 'ricv_',
                  tmpdir  = ggsave_dir,
                  fileext = ggsave_ext)
                )
    }else if(sum(is_gg) != length(ggsave_fnames)){
      stop('Length of ggsave_fnames should be the same as number of ggplot2 objects passed as arguments.')
    }else if(is_gg[2] & length(ggsave_fnames) == 1){
      ggsave_fnames = c(img1, ggsave_fnames) # only second filename is needed, because img1 must be an image file
    }

    # Save the ggplot2 objects
    if(is_gg[1]){
      ggplot2::ggsave(
        filename = ggsave_fnames[1],
        plot     = img1, ...
        )
      img1 = ggsave_fnames[1]
    }
    if(is_gg[2]){
      ggplot2::ggsave(
        filename = ggsave_fnames[2],
        plot     = img2, ...
      )
      img2 = ggsave_fnames[2]
    }
  }

  x <- list(
    img1 = img1,
    img2 = img2,
    options = unclass(valid_options),
    css = css
  )

  htmlwidgets::createWidget(
    name = "ricv",
    x,
    width = NULL,
    height = NULL,
    package = "ricv",
    sizingPolicy = htmlwidgets::sizingPolicy(padding = 0)
  )
}

#' Shiny bindings for ricv
#'
#' Output and render functions for using ricv within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a ricv
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name ricv-shiny
#'
#' @export
ricvOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'ricv', width, height, package = 'ricv')
}

#' @rdname ricv-shiny
#' @export
renderRicv <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, ricvOutput, env, quoted = TRUE)
}
