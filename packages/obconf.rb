require 'package'

class Obconf < Package
  description 'ObConf - Openbox configuration tool'
  homepage 'http://openbox.org/wiki/ObConf:About'
  version '2.0.4'
  compatibility 'all'
  source_url 'http://openbox.org/dist/obconf/obconf-2.0.4.tar.gz'
  source_sha256 '71a3e5f4ee246a27421ba85044f09d449f8de22680944ece9c471cd46a9356b9' 

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
