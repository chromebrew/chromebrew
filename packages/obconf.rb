require 'package'

class Obconf < Package
  description 'ObConf - Openbox configuration tool'
  homepage 'http://openbox.org/wiki/ObConf:About'
  version '2.0.4'
  compatibility 'all'
  source_url 'http://openbox.org/dist/obconf/obconf-2.0.4.tar.gz'
  source_sha256 '71a3e5f4ee246a27421ba85044f09d449f8de22680944ece9c471cd46a9356b9' 

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/obconf-2.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/obconf-2.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/obconf-2.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/obconf-2.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e11f0fbb1d393185c455d03faef83ee21e4166afbb4e0676dd0b176a6113b9a3',
     armv7l: 'e11f0fbb1d393185c455d03faef83ee21e4166afbb4e0676dd0b176a6113b9a3',
       i686: 'ef68ba89facc43bdd81029ff643414d418a9ce101fa0c7023dda1c615b111972',
     x86_64: '269b7e861ced2a76d203881329de5ce2bddf2b48588a13d341b01e78872844fd',
  })

  depends_on 'libglade'
  depends_on 'openbox'

  def self.build
    system "./configure",
           "--mandir=#{CREW_PREFIX}/share/man",
           "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
