require 'buildsystems/meson'

class Curtail < Meson
  description 'Curtail (previously ImCompressor) is an useful image compressor, supporting PNG, JPEG and WEBP file types.'
  homepage 'https://github.com/Huluti/Curtail'
  version '1.17.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/Huluti/Curtail.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd3edb67248592218d01085c5b83fe28ea0d2b965432931423885d9ec7ee5a475',
     armv7l: 'd3edb67248592218d01085c5b83fe28ea0d2b965432931423885d9ec7ee5a475',
     x86_64: '9d8d5370f55143b2f67fb42c651ba34e4eed2491e4e2953034f4ddaa5724b14b'
  })

  depends_on 'appstream' => :build
  depends_on 'blueprint_compiler' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' => :build
  depends_on 'jpegoptim' => :build
  depends_on 'libadwaita' => :build
  depends_on 'libwebp' => :build
  depends_on 'optipng' => :build
  depends_on 'pngquant' => :build
end
