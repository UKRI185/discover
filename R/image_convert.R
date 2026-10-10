dir_in  <- "images"
quality <- 100    # 0-100; lower = smaller file
max_w   <- 1600  # resize if wider than this (pixels); NULL to keep size
 
files <- list.files(dir_in, pattern = "\\.(jpe?g|png|tiff?|bmp|gif)$",
                    ignore.case = TRUE, full.names = TRUE)
 
for (f in files) {
  img <- magick::image_read(f)
  if (!is.null(max_w) && magick::image_info(img)$width > max_w) {
    img <- magick::image_resize(img, paste0(max_w, "x"))
  }
  out <- paste0(tools::file_path_sans_ext(f), ".webp")
  magick::image_write(img, out, format = "webp", quality = quality)
  cat(sprintf("%s -> %s\n", basename(f), basename(out)))
}
