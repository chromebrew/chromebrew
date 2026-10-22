require 'buildsystems/meson'

class Audacious_plugins < Meson
  description 'Audacious is an open source audio player.'
  homepage 'https://github.com/audacious-media-player/audacious-plugins'
  version '4.6.2'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://distfiles.audacious-media-player.org/audacious-plugins-#{version}.tar.bz2"
  source_sha256 'c295c65bdaae71775b4fa9eb206799c627b383c4f45444d637c714196daf8077'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f51f7ef58f04b612af1fc8051f5901a82fa98ec039dd47b15ad3430f4a6fd174',
     armv7l: 'f51f7ef58f04b612af1fc8051f5901a82fa98ec039dd47b15ad3430f4a6fd174',
     x86_64: 'e81dd6004dd313088155383a1730f087f1b1e9fdac2e052d3d6c70d1e8dc39cc'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'at_spi2_core' => :build
  depends_on 'audacious' => :library
  depends_on 'cairo' => :library
  depends_on 'curl' => :library
  depends_on 'flac' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :build
  depends_on 'json_glib' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libogg' => :library
  depends_on 'libvorbis' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcomposite' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxrender' => :library
  depends_on 'mpg123' => :library
  depends_on 'neon' => :library
  depends_on 'pango' => :library
  depends_on 'wavpack' => :library
  depends_on 'zlib' => :library

  meson_options '-Dopus=false -Dqt=false'
end
