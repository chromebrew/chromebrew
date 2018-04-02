require 'package'

class Pangomm < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  version '2.40.1'
  source_url 'http://ftp.acc.umu.se/pub/GNOME/sources/pangomm/2.40/pangomm-2.40.1.tar.xz'
  source_sha256 '9762ee2a2d5781be6797448d4dd2383ce14907159b30bc12bf6b08e7227be3af'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.40.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.40.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.40.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pangomm-2.40.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '93a4e4b1c777485381bbc5c4500e168276a20431cfc801c890372523f632d68a',
     armv7l: '93a4e4b1c777485381bbc5c4500e168276a20431cfc801c890372523f632d68a',
       i686: '92fd54dd0047ee75a7e5a584e1ed6a209581c155bc6756f43bac606ba661e6ad',
     x86_64: 'cbd631d55c635773fb18f1d1354dc2f1c13d339638ea2828a503b6cc03c4e191',
  })

  depends_on 'glibmm'
  depends_on 'cairomm'
  depends_on 'pango'
  
  def self.build
    system "sed -e '/^libdocdir =/ s/$(book_name)/pangomm-2.40.1/' \
    -i docs/Makefile.in"
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    #system "pip install six"  # for installation process
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    #system "pip uninstall --yes six"
  end
  

end
