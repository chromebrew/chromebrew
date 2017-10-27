require 'package'

class Elinks < Package
  description 'Full-Featured Text WWW Browser'
  homepage 'http://elinks.or.cz/'
  version 'f86be65971'

  source_url 'https://git.phpizza.com/alan/elinks/archive/f86be659718c0cd0a67f88b42f07044c23d0d028.tar.gz'
  source_sha256 'ce416fdd57b23442275b5d74c80e0ac5793b66ec0f8ed07500c64eb647339838'

  depends_on 'bz2'
  depends_on 'lzip'
  depends_on 'openssl'
  depends_on 'zlibpkg'

  def self.build
    system "wget -O config/config.guess 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'"
    system "wget -O config/config.sub 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'"
    system "sh autogen.sh" unless File.executable? "configure"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
