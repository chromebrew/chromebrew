require 'buildsystems/meson'

class Audacious < Meson
  description 'Audacious is an open source audio player.'
  homepage 'https://audacious-media-player.org/'
  version '4.6.2'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://distfiles.audacious-media-player.org/audacious-#{version}.tar.bz2"
  source_sha256 'af4c68b7dd09304d382df18616aecd843c8efa4e4eef31bfc76abce465271c83'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0712eac4bc832a39ceb206bff9e9d14b4f47131ffe5a5e802a804bcc50fa01e2',
     armv7l: '0712eac4bc832a39ceb206bff9e9d14b4f47131ffe5a5e802a804bcc50fa01e2',
     x86_64: 'ed2cff755c69aa3b2aa16c84482e68b5efda1555e56fc8f9b3765bfeab835d4f'
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
