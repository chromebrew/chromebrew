require 'package'

class Elinks < Package
  description 'Full-Featured Text WWW Browser'
  homepage 'http://elinks.or.cz/'
  version '0.13'

  source_url 'http://elinks.cz/download/elinks-current-0.13.tar.gz'
  source_sha256 '39f3101c1c39808193b92907dbb779b21bc175a8d381ee05d663680c65aef557'

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
