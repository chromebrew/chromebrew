require 'buildsystems/meson'

class Mate_desktop < Meson
  description 'Libraries for the MATE desktop that are not part of the UI.'
  homepage 'https://mate-desktop.org'
  version '1.29.0'
  license 'FDL-1.1, GPL-2+, LGPL-2+, MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/mate-desktop/mate-desktop.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d766f7c38aff2b928334ff41884314c761764a078532c9f7ea741742e6cd3c0',
     armv7l: '0d766f7c38aff2b928334ff41884314c761764a078532c9f7ea741742e6cd3c0',
     x86_64: 'ab805f6cda35b42371278d8f6adf55721620f36f7730a23a5fedddc304bf209f'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'dconf' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'iso_codes' => :build
  depends_on 'libbsd' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxdmcp' => :library
  depends_on 'libxrandr' => :library
  depends_on 'mate_common' => :build
  depends_on 'pango' => :library
  depends_on 'startup_notification' => :library
  depends_on 'zlib' => :library

  meson_options '-Dintrospection=true'
end
