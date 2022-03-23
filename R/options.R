assert_type_unit_set <- function(test, type_in_msg, x, k, mandatory) {
  if (is.null(x) && mandatory)
    stop(paste(k, "in options cannot be null or missing"), call. = F)

  if (!is.null(x) && !test(x)) stop(
    paste(k, "in options should be a single element of type", type_in_msg, "but is a", typeof(x)),
    call. = F
  )

  if(!is.null(x) && length(x) > 1) stop(
    paste(k, "in options should be a single element but is made of", length(x), "values"),
    call. = F
  )
}
assert_character_unit_set <- function(x, k, mandatory = FALSE) {
  assert_type_unit_set(is.character, "character", x, k, mandatory = mandatory)
}
assert_numeric_unit_set <- function(x, k, mandatory = FALSE) {
  assert_type_unit_set(is.numeric, "numeric", x, k, mandatory = mandatory)
}
assert_logical_unit_set <- function(x, k, mandatory = FALSE) {
  assert_type_unit_set(is.logical, "logical", x, k, mandatory = mandatory)
}

assert_known_attributes <- function(given, expected, src) {
  names_diff <- setdiff(given, expected)
  if (!identical(names_diff, character(0))) {
    if (length(names_diff) == 1) {
      stop(paste("One of the given", src, "options attributes is not valid:", names_diff),
           call. = FALSE)
    } else {
      stop(paste("Some of the given", src, "options attributes are not valid:", paste(names_diff, collapse = ", ")),
           call. = FALSE)
    }
  }
}


new_Options <- function(x = list()) {
  if (is.null(x)) {
    return(structure(list(), class = "Options"))
  }
  if (is.list(x) && length(x) == 0) {
    return(structure(list(), class = "Options"))
  }

  stopifnot("options must be a list or NULL"=is.list(x))

  top_level_names <- c(
    "controlColor",
    "controlShadow",
    "addCircle",
    "addCircleBlur",
    "showLabels",
    "labelOptions",
    "smoothing",
    "smoothingAmount",
    "hoverStart",
    "verticalMode",
    "startingPoint",
    "fluidMode"
  )

  assert_known_attributes(names(x), top_level_names, "top level")

  if (!is.null(x$labelOptions)) {
    label_options_names <- c("before", "after", "onHover")
    assert_known_attributes(names(x$labelOptions), label_options_names, "labelOptions")

    assert_character_unit_set(x$labelOptions$before, "before")
    assert_character_unit_set(x$labelOptions$after, "after")
    assert_logical_unit_set(x$labelOptions$onHover, "onHover")
  }

  assert_character_unit_set(x$controlColor, "controlColor")
  assert_logical_unit_set(x$controlShadow, "controlShadow")
  assert_logical_unit_set(x$addCircle, "addCircle")
  assert_logical_unit_set(x$addCircleBlur, "addCircleBlur")
  assert_logical_unit_set(x$showLabels, "showLabels")
  assert_logical_unit_set(x$smoothing, "smoothing")
  assert_numeric_unit_set(x$smoothingAmount, "smoothingAmount")
  assert_logical_unit_set(x$hoverStart, "hoverStart")
  assert_logical_unit_set(x$verticalMode, "verticalMode")
  assert_numeric_unit_set(x$startingPoint, "startingPoint")
  assert_logical_unit_set(x$fluidMode, "fluidMode")

  structure(x, class = "Options")
}

#' Create ricv options
#'
#' This function helps you create the list of options that ricv can accept. None of them are mandatory.
#' One can also create the list by hand, this function is just meant to help you remember the possible
#' attributes.
#'
#' @param labelOptionsBefore A character string for the 'before' label.
#' @param labelOptionsAfter A character string for the 'after' label.
#' @param labelOptionsOnHover A logical. Whether or not to show the labels only on hover.
#' @param controlColor A character string representing a hex color (e.g. "#FFFFFF") for the control line/arrows.
#' @param controlShadow A logical. Whether or not to add a shadow for the control line/arrows.
#' @param addCircle A logical. Whether or not to add a circle around the control line/arrows.
#' @param addCircleBlur A logical. Whether or not to add a blur in the circle around the control line/arrows.
#' @param showLabels A logical. Whether or not to show the 'before'/'after' labels (see also the other labelOptions... arguments).
#' @param smoothing A logical. Whether or not to smooth (i.e. dampen) the movement of the control line/arrows.
#' @param smoothingAmount A numeric value. Set the amount of smoothing.
#' @param hoverStart A logical. Whether or not to activate click-less control.
#' @param verticalMode A logical. Whether or not to set the control to vertical mode.
#' @param startingPoint A numeric value. Represent the percentage where the line start (e.g. '50' means the middle 50%).
#' @param fluidMode A logical. Fluid mode enables the container to have fluid height and width, independent of each other, useful for using Image Compare Viewer in a full screen container for instance. The image is dynamically cropped using the CSS background 'cover' property.
#'
#' @return a list of options that can be used for the `options` argument of \code{\link{ricv}}
#' @export
ricv_opts <- function(
  labelOptionsBefore = "Before",
  labelOptionsAfter = "After",
  labelOptionsOnHover = TRUE,
  controlColor = "#FFFFFF",
  controlShadow = TRUE,
  addCircle = TRUE,
  addCircleBlur = TRUE,
  showLabels = TRUE,
  smoothing = TRUE,
  smoothingAmount = 200,
  hoverStart = FALSE,
  verticalMode = FALSE,
  startingPoint = 50,
  fluidMode = FALSE
) {
  assert_character_unit_set(labelOptionsBefore, "labelOptionsBefore")
  assert_character_unit_set(labelOptionsAfter, "labelOptionsAfter")
  assert_logical_unit_set(labelOptionsOnHover, "labelOptionsOnHover")
  assert_character_unit_set(controlColor, "controlColor")
  assert_logical_unit_set(controlShadow, "controlShadow")
  assert_logical_unit_set(addCircle, "addCircle")
  assert_logical_unit_set(addCircleBlur, "addCircleBlur")
  assert_logical_unit_set(showLabels, "showLabels")
  assert_logical_unit_set(smoothing, "smoothing")
  assert_numeric_unit_set(smoothingAmount, "smoothingAmount")
  assert_logical_unit_set(hoverStart, "hoverStart")
  assert_logical_unit_set(verticalMode, "verticalMode")
  assert_numeric_unit_set(startingPoint, "startingPoint")
  assert_logical_unit_set(fluidMode, "fluidMode")

  options <- list()
  options$controlColor <- controlColor
  options$controlShadow <- controlShadow
  options$addCircle <- addCircle
  options$addCircleBlur <- addCircleBlur
  options$showLabels <- showLabels
  options$smoothing <- smoothing
  options$smoothingAmount <- smoothingAmount
  options$hoverStart <- hoverStart
  options$verticalMode <- verticalMode
  options$startingPoint <- startingPoint
  options$fluidMode <- fluidMode

  if (!is.null(labelOptionsBefore) || !is.null(labelOptionsAfter) || !is.null(labelOptionsOnHover)) {
    options$labelOptions <- list()
    options$labelOptions$before <- labelOptionsBefore
    options$labelOptions$after <- labelOptionsAfter
    options$labelOptions$onHover <- labelOptionsOnHover
  }

  options
}
