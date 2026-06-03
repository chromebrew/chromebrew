require 'buildsystems/meson'

class Audacious_plugins < Meson
  description 'Audacious is an open source audio player.'
  homepage 'https://github.com/audacious-media-player/audacious-plugins'
  version '4.6'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://distfiles.audacious-media-player.org/audacious-plugins-#{version}.tar.bz2"
  source_sha256 'ce708bca0194d3a1b2b8a89a2892e1c7798f374593563fb21c4c64b24ab8d83a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4590895debbab7dff1a6cfeae080d2b77a8ac15afcfc1872685ecbe60b650aac',
     armv7l: '4590895debbab7dff1a6cfeae080d2b77a8ac15afcfc1872685ecbe60b650aac',
     x86_64: 'cb2ebdf7ff22f173a9ac532017013496d5f7f2367edd2e3eef2e4673ae06f3c8'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'audacious' # R
  depends_on 'cairo' # R
  depends_on 'curl' # R
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

  meson_options '-Dopus=false -Dqt=false'
end
