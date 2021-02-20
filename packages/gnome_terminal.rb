require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  version '3.39.90'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gnome-terminal/3.39/gnome-terminal-3.39.90.tar.xz"
  source_sha256 '68bbd2b20c533f1648d4ba5625dbcb35270e5c958713faaad30ea0167c3d8199'

  depends_on 'gtk3'
  depends_on 'vte'
  depends_on 'dconf'
  depends_on 'desktop_file_utilities'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'yelp_tools'
  depends_on 'sommelier'
  
  def self.build
    ENV['CFLAGS'] = '-pipe -flto'
    ENV['CXXFLAGS'] ='-pipe -flto'
    system "env CFLAGS = '-pipe -flto' \
                CXXFLAGS = '-pipe -flto' \
            ./configure #{CREW_OPTIONS} \
              --disable-search-provider \
              --without-nautilus-extension \
              --with-gtk=3.0"
    system 'make'
  end
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
