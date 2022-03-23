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

opts <- function(

) {
  assert_character_unit_set(label_options$before, "before")
  assert_character_unit_set(labelOptions$after, "after")
  assert_logical_unit_set(labelOptions$onHover, "onHover")
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
}
