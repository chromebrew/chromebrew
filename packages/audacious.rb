require 'buildsystems/meson'

class Audacious < Meson
  description 'Audacious is an open source audio player.'
  homepage 'https://audacious-media-player.org/'
  version '4.6.1'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://distfiles.audacious-media-player.org/audacious-#{version}.tar.bz2"
  source_sha256 '62a5a609267eca7f6e3ce52ef6f42d5618d2961e3b4ddc227c6a5859026965d9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9ce972c1c0c2c55a3aced050ec028bf52b3a7d466f6bc09839782a6c913d65a',
     armv7l: 'c9ce972c1c0c2c55a3aced050ec028bf52b3a7d466f6bc09839782a6c913d65a',
     x86_64: '7ed6d408a8c11c0f0a0b5e6a54c295ce4c8c80eae10676d0c6b91dda9caf96dd'
  })

  depends_on 'at_spi2_core' => :build
  # depends_on 'audacious_plugins' => :runtime
  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :build
  depends_on 'pango' => :library
  depends_on 'sommelier' => :logical
  depends_on 'xdg_base' => :logical
  depends_on 'zlib' => :build

  meson_options '-Ddbus=false -Dqt=false'

  def self.postinstall
    ExitMessage.add <<~EOM
      To configure, execute the following:
      Type 'audacious' to launch the music player.
      From the menu, select 'Output' > 'Audio Settings'.
      Select 'ALSA Output' for the 'Output plugin'.
      Click 'Settings' to the right of 'ALSA Output'.
      Select 'sysdefault - Default control device' for 'Mixer device'.
      Click 'Close' and 'Close' again to save.
    EOM
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.config/audacious")
  end
end
