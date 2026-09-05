require 'buildsystems/meson'

class Audacious_plugins < Meson
  description 'Audacious is an open source audio player.'
  homepage 'https://github.com/audacious-media-player/audacious-plugins'
  version '4.6.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://distfiles.audacious-media-player.org/audacious-plugins-#{version}.tar.bz2"
  source_sha256 '22e58a8a2c3f3caa9687434353618c822963cc8846cd239de36d4e8e5bd166a6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f60e95c190df4badde9f8957607b6e368274adc175dfcded30d7df083f06ba1e',
     armv7l: 'f60e95c190df4badde9f8957607b6e368274adc175dfcded30d7df083f06ba1e',
     x86_64: 'bdf6ba5ef9442bfcd907b6493b0ec5f68f45e89dd13d4e2901366e8cc0457eb7'
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
