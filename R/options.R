is_character_or_null <- function(x) {
  (is.character(x) && length(x) == 1) || is.null(x)
}
is_logical_or_null <- function(x) {
  (is.logical(x) && length(x) == 1) || is.null(x)
}
is_numeric_or_null <- function(x) {
  (is.numeric(x) && length(x) == 1) || is.null(x)
}

new_Options <- function(x = list()) {
  top_level_options <- c(
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

  stopifnot(setdiff(names(x), top_level_options) != character(0))

  if (!is.null(x$labelOptions)) {
    label_options <- c("before", "after", "onHover")
    stopifnot(setdiff(names(x$labelOptions), label_options) != character(0))

    stopifnot(is_character_or_null(x$labelOptions$before))
    stopifnot(is_character_or_null(x$labelOptions$after))
    stopifnot(is_logical_or_null(x$labelOptions$onHover))
  }

  stopifnot(is_character_or_null(x$controlColor))
  stopifnot(is_logical_or_null(x$controlShadow))
  stopifnot(is_logical_or_null(x$addCircle))
  stopifnot(is_logical_or_null(x$addCircleBlur))
  stopifnot(is_logical_or_null(x$addshowLabels))
  stopifnot(is_logical_or_null(x$smoothing))
  stopifnot(is_numeric_or_null(x$smoothingAmount))
  stopifnot(is_logical_or_null(x$hoverStart))
  stopifnot(is_logical_or_null(x$verticalMode))
  stopifnot(is_numeric_or_null(x$startingPoint))
  stopifnot(is_logical_or_null(x$fluidMode))

  structure(x, class = "Options")
}
