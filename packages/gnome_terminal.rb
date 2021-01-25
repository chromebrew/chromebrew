require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  @_ver = '3.38.2'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/GNOME/gnome-terminal/archive/#{@_ver}.tar.gz"
  source_sha256 'cb2a3ca5fde192998f875b2d1b4cc1caca899d936714fe9324cb66735abf68a0'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_terminal-3.38.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_terminal-3.38.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_terminal-3.38.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_terminal-3.38.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '274701d4a532d9b2db1ba69eb6c2d6ba1942e7c950029af5c1cfe52cc20d951d',
      armv7l: '274701d4a532d9b2db1ba69eb6c2d6ba1942e7c950029af5c1cfe52cc20d951d',
        i686: '3234511570b9fbe2a8a77367ef92619275c35753493fcac240635e09e1bd91db',
      x86_64: '00cb44ba43b4f1059dbb8d769d25f8a86b627217d44ec139fde44a2bdc48ed10',
  })

  depends_on 'gtk3'
  depends_on 'vte'
  depends_on 'dconf'
  depends_on 'desktop_file_utilities'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'yelp_tools'
  
  def self.build
    system "env CFLAGS='-pipe -flto' CXXFLAGS='-pipe -flto' ./autogen.sh #{CREW_OPTIONS} \
    --disable-search-provider \
    --without-nautilus-extension"
    Dir.chdir 'src' do
      system 'make'
    end
  end
  def self.install
    Dir.chdir 'src' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
