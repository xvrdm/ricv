#' Create an interactive image comparator
#'
#' This function creates an interactive image comparator. See website of the
#' underlying project for examples: https://image-compare-viewer.netlify.app/
#'
#' @param img1 A path to an image file. This image will be placed to the left.
#' @param img2 A path to an image file. This image will be placed to the right.
#' @param options A list of image-compare-viewer options. See examples.
#'
#' @examples
#' ricv("myimage1.jpg", "myimage2.jpg)
#'
#' ricv("img1.jpg", "img2.jpg", list(addCircle = T, hoverStart = T))
#'
#' @import htmlwidgets
#'
#' @export
ricv <- function(img1, img2, options = NULL) {

  x <- list(
    img1 = img1,
    img2 = img2,
    options = options
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
