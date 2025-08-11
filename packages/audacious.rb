require 'buildsystems/autotools'

class Audacious < Autotools
  description 'Audacious is an open source audio player.'
  homepage 'https://audacious-media-player.org/'
  version '4.5'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://distfiles.audacious-media-player.org/audacious-#{version}.tar.bz2"
  source_sha256 '1ea5e0f871c6a8b2318e09a9d58fc573fe3f117ae0d8d163b60cc05b2ce7c405'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d20a44ff9efcc984fad709fedf198d226ea9816945f5c1b0e4c2ea2ab4af3b8',
     armv7l: '2d20a44ff9efcc984fad709fedf198d226ea9816945f5c1b0e4c2ea2ab4af3b8',
     x86_64: '7223fd048011675270767994ba0aa0fe49309c84102245b187ddd7ac36a40475'
  })

  depends_on 'at_spi2_core' # R
  # depends_on 'audacious_plugins' => :runtime
  depends_on 'cairo' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'pango' # R
  depends_on 'sommelier'
  depends_on 'xdg_base'
  depends_on 'zlib' # R

  autotools_configure_options '--disable-dbus \
                               --disable-qt'

  def self.postinstall
    puts
    puts 'To configure, execute the following:'.lightblue
    puts "Type 'audacious' to launch the music player.".lightblue
    puts "From the menu, select 'Output' > 'Audio Settings'.".lightblue
    puts "Select 'ALSA Output' for the 'Output plugin'.".lightblue
    puts "Click 'Settings' to the right of 'ALSA Output'.".lightblue
    puts "Select 'sysdefault - Default control device' for 'Mixer device'.".lightblue
    puts "Click 'Close' and 'Close' again to save.".lightblue
    puts
    puts 'To completely remove, execute the following:'.lightblue
    puts 'crew remove audacious audacious_plugins'.lightblue
    puts 'rm -rf ~/.config/audacious'.lightblue
    puts
  end
end
