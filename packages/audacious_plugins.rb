require 'buildsystems/autotools'

class Audacious_plugins < Autotools
  description 'Audacious is an open source audio player.'
  homepage 'https://github.com/audacious-media-player/audacious-plugins'
  version '4.5.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://distfiles.audacious-media-player.org/audacious-plugins-#{version}.tar.bz2"
  source_sha256 'f4feedc32776acfa9d24701d3b794fc97822f76da6991e91e627e70e561fdd3b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12d6510f1bf2fe266e0b2749c1285e5f634d99eea17d770602bcdfc3048f5818',
     armv7l: '12d6510f1bf2fe266e0b2749c1285e5f634d99eea17d770602bcdfc3048f5818',
     x86_64: 'd00000415a164d4154308eaedbdec825bf37e90edc8dade86ae11de66c21a62e'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'audacious' # R
  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'flac' # R
  depends_on 'flac' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libglvnd' # R
  depends_on 'libogg' # R
  depends_on 'libvorbis' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxml2' # R
  depends_on 'libxrender' # R
  depends_on 'mpg123' # R
  depends_on 'neon' # R
  depends_on 'pango' # R
  depends_on 'wavpack'
  depends_on 'zlib' # R

  autotools_configure_options '--disable-opus --disable-qt'
end
