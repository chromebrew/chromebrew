require 'buildsystems/meson'

class Curtail < Meson
  description 'Curtail (previously ImCompressor) is an useful image compressor, supporting PNG, JPEG and WEBP file types.'
  homepage 'https://github.com/Huluti/Curtail'
  version '1.16.2'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Huluti/Curtail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3352d0a5a64e6d837e03b9c910b33adf4ec7eeacba9c3996ae0018683bc4d81',
     armv7l: 'd3352d0a5a64e6d837e03b9c910b33adf4ec7eeacba9c3996ae0018683bc4d81',
     x86_64: 'd2e0fd2a8c490e8210f6940e88a83f03df922d96bf48786d9f7eea8b9ea6b708'
  })

  depends_on 'appstream' => :library
  depends_on 'blueprint_compiler' => :library
  depends_on 'desktop_file_utils' => :library
  depends_on 'gobject_introspection' => :library
  depends_on 'gtk4' => :library
  depends_on 'jpegoptim' => :library
  depends_on 'libadwaita' => :library
  depends_on 'libwebp' => :library
  depends_on 'optipng' => :library
  depends_on 'pngquant' => :library
end
