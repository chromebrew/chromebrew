require 'buildsystems/autotools'

class Magic < Autotools
  description 'Magic is a venerable VLSI layout tool'
  homepage 'http://opencircuitdesign.com/magic/'
  version '8.3.513'
  license 'HPND-UC-export-US'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/RTimothyEdwards/magic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd79946662a86b2691f78b594ae0694ae07deb566848be63924fd00fafbe36693',
     armv7l: 'd79946662a86b2691f78b594ae0694ae07deb566848be63924fd00fafbe36693',
     x86_64: '063af0803d89568fef8d1d0b1749f9f73fe85ec600c937aa6a2c5e92ee4fbfa5'
  })

  depends_on 'cairo'
  depends_on 'tcl'
  depends_on 'tk'
  depends_on 'harfbuzz' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'zlib' # R

  # https://github.com/RTimothyEdwards/magic/issues/323
  configure_options "--with-tcl=#{CREW_LIB_PREFIX} --with-tk=#{CREW_LIB_PREFIX} CFLAGS='-fpermissive'"
end
