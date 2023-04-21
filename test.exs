Mix.install([
  {:vix, "~> 0.18.0"}
])

IO.puts "Loading image"
{:ok, img} = Vix.Vips.Image.new_from_file("test.jpg")

IO.puts "Saving unmodified image as jpeg"
Vix.Vips.Operation.jpegsave(img, "vix-unmodified.jpeg", Q: 100)

IO.puts "Saving unmodified image as avif"
Vix.Vips.Operation.heifsave(img, "vix-unmodified.avif", lossless: true, compression: :VIPS_FOREIGN_HEIF_COMPRESSION_AV1)

IO.puts "Performing icc_transform"
{:ok, newimg} = Vix.Vips.Operation.icc_transform(img, "DisplayP3-v4.icc", embedded: true, depth: 16)

IO.puts "Saving modified image as jpeg"
Vix.Vips.Operation.jpegsave(newimg, "vix-modified.jpeg", Q: 100)

IO.puts "Saving modified image as avif"
Vix.Vips.Operation.heifsave(newimg, "vix-modified.avif", lossless: true, compression: :VIPS_FOREIGN_HEIF_COMPRESSION_AV1)
