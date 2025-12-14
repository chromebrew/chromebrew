require 'buildsystems/autotools'

class Audacious < Autotools
  description 'Audacious is an open source audio player.'
  homepage 'https://audacious-media-player.org/'
  version '4.5.1'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://distfiles.audacious-media-player.org/audacious-#{version}.tar.bz2"
  source_sha256 '1ea5e0f871c6a8b2318e09a9d58fc573fe3f117ae0d8d163b60cc05b2ce7c405'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6fc8c8358b4376cd4b3d7953e2287e0c1b63e6e8ef6b0ac009f43ba6dca9b439',
     armv7l: '6fc8c8358b4376cd4b3d7953e2287e0c1b63e6e8ef6b0ac009f43ba6dca9b439',
     x86_64: 'a67a555c3517b4497e556c0737412581dc64c7a06f6c7b91c3adae4bd30cc681'
  })

  # depends_on 'audacious_plugins' => :runtime
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'pango' # R
  depends_on 'sommelier'
  depends_on 'xdg_base'
  depends_on 'zlib' # R

  autotools_configure_options '--disable-dbus \
                               --disable-qt'

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
