require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  version '3.39.90'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gnome-terminal/3.39/gnome-terminal-3.39.90.tar.xz'
  source_sha256 '68bbd2b20c533f1648d4ba5625dbcb35270e5c958713faaad30ea0167c3d8199'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_terminal-3.39.90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_terminal-3.39.90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_terminal-3.39.90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_terminal-3.39.90-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '64e9b60071ff95ecca092aa1468a8c2c4f82913e531b2ea456c525007634e426',
     armv7l: '64e9b60071ff95ecca092aa1468a8c2c4f82913e531b2ea456c525007634e426',
       i686: '22c50f78a594fded61c48656aaae5e8b378086ca1a339c2ceebb6838ffaed425',
     x86_64: '9745dded864e889d64e5e3e04215240765ee0be748fbad5a9c3db84f58ec91c5'
  })

  depends_on 'gtk3'
  depends_on 'vte'
  depends_on 'dconf'
  depends_on 'desktop_file_utilities'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'yelp_tools'
  depends_on 'sommelier'

  def self.build
    system "env CFLAGS='-pipe -flto' \
      CXXFLAGS='-pipe -flto' \
      LDFLAGS='-flto' \
      ./configure #{CREW_OPTIONS} \
      --disable-search-provider \
      --without-nautilus-extension \
      --with-gtk=3.0"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
