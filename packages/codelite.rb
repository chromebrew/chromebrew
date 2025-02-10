require 'buildsystems/cmake'

class Codelite < CMake
  description 'CodeLite is an open source, free, cross platform IDE, specialized in C, C++, Rust, Python, PHP and JavaScript'
  homepage 'https://codelite.org/'
  version '18.1.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/eranif/codelite.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9cf8797135276f7d0e84d39c53dc5bdcf602f73023382e42e6c3f81389507389',
     armv7l: '9cf8797135276f7d0e84d39c53dc5bdcf602f73023382e42e6c3f81389507389',
     x86_64: '447f8d99e7e5875c3bd17c38a21e184b2b976f80fd9c903d128eb5123513b54f'
  })

  depends_on 'libedit'
  depends_on 'libssh'
  depends_on 'sqlite'
  depends_on 'wxwidgets'
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'harfbuzz' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'pango' # R
  depends_on 'uchardet' # R
end
