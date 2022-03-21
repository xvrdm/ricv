assert_type_unit_set <- function(test, type_in_msg, x, k, mandatory) {
  if (is.null(x[[k]]) && mandatory)
    stop(paste(k, "in options cannot be null or missing"), call. = F)

  if (!is.null(x[[k]]) && !test(x[[k]])) stop(
    paste(k, "in options should be a single element of type", type_in_msg, "but is a", typeof(x[[k]])),
    call. = F
  )

  if(!is.null(x[[k]]) && length(x[[k]]) > 1) stop(
    paste(k, "in options should be a single element but is made of", length(x[[k]]), "values"),
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
  if (is.null(x)) return(list())
  if (is.list(x) && length(x) == 0) return(list())

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

    label_options <- x$labelOptions
    assert_character_unit_set(label_options, "before")
    assert_character_unit_set(labelOptions, "after")
    assert_logical_unit_set(labelOptions, "onHover")
  }

  assert_character_unit_set(x, "controlColor")
  assert_logical_unit_set(x, "controlShadow")
  assert_logical_unit_set(x, "addCircle")
  assert_logical_unit_set(x, "addCircleBlur")
  assert_logical_unit_set(x, "addshowLabels")
  assert_logical_unit_set(x, "smoothing")
  assert_numeric_unit_set(x, "smoothingAmount")
  assert_logical_unit_set(x, "hoverStart")
  assert_logical_unit_set(x, "verticalMode")
  assert_numeric_unit_set(x, "startingPoint")
  assert_logical_unit_set(x, "fluidMode")

  structure(ifelse(is.null(x), list(), x), class = "Options")
}
