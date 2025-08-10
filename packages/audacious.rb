require 'package'

class Audacious < Package
  description 'Audacious is an open source audio player.'
  homepage 'https://audacious-media-player.org/'
  version '4.5'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://distfiles.audacious-media-player.org/audacious-3.10.1.tar.bz2'
  source_sha256 '8366e840bb3c9448c2cf0cf9a0800155b0bd7cc212a28ba44990c3d2289c6b93'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba6f82f28f35f02059be703f7360eeb44660561995592db41f80c9944853e4ad',
     armv7l: 'ba6f82f28f35f02059be703f7360eeb44660561995592db41f80c9944853e4ad',
     x86_64: '631f3e20599b98e94ddf0acd36805ed8daed499218df202b8fc5249d3245fc0b'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'audacious_plugins' => :runtime
  depends_on 'cairo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'harfbuzz' # R
  depends_on 'mpg123'
  depends_on 'pango' # R
  depends_on 'qt5_base'
  depends_on 'sommelier'
  depends_on 'xdg_base'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dbus',
           '--enable-qt'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

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
