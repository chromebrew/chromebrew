require 'package'

class Audacious < Package
  description 'Audacious is an open source audio player.'
  homepage 'https://audacious-media-player.org/'
  version '3.10.1'
  compatibility 'all'
  source_url 'https://distfiles.audacious-media-player.org/audacious-3.10.1.tar.bz2'
  source_sha256 '8366e840bb3c9448c2cf0cf9a0800155b0bd7cc212a28ba44990c3d2289c6b93'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/audacious-3.10.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/audacious-3.10.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/audacious-3.10.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/audacious-3.10.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6597ca2c03a630bc4da5ff6f0543e2dc5a4d7621b9bcdb2828fe49fc3889df9d',
     armv7l: '6597ca2c03a630bc4da5ff6f0543e2dc5a4d7621b9bcdb2828fe49fc3889df9d',
       i686: '7176161f5e71887d35338b7e18bc5524b907d9c334454ea6409e043eb5527806',
     x86_64: '5660d4bbee7230c4b2698973b2a82a45e20461dba246fb22fcdbf91be74b9793',
  })

  depends_on 'audacious_plugins' => :runtime
  depends_on 'gdbm'
  depends_on 'gtk2'
  depends_on 'qtbase'
  depends_on 'mpg123'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dbus',
           '--enable-qt'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.postinstall
    puts
    puts "To configure, execute the following:".lightblue
    puts "Type 'audacious' to launch the music player.".lightblue
    puts "From the menu, select 'Output' > 'Audio Settings'.".lightblue
    puts "Select 'ALSA Output' for the 'Output plugin'.".lightblue
    puts "Click 'Settings' to the right of 'ALSA Output'.".lightblue
    puts "Select 'sysdefault - Default control device' for 'Mixer device'.".lightblue
    puts "Click 'Close' and 'Close' again to save.".lightblue
    puts
    puts "To completely remove, execute the following:".lightblue
    puts "crew remove audacious audacious_plugins".lightblue
    puts "rm -rf ~/.config/audacious".lightblue
    puts
  end
end
