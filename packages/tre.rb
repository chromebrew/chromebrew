require 'package'

class Tre < Package
  description 'The approximate regex matching library and agrep command line tool.'
  homepage 'https://github.com/laurikari/tre'
  version '6fb720'
  source_url 'https://github.com/laurikari/tre/archive/6fb7206b935b35814c5078c20046dbe065435363.tar.gz'
  source_sha256 'd2810576685b10c6bf9270793550032bdada04afd963fa4670a08fdc57859bdd'

  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'gettext'
  depends_on 'libtool'

  def self.build
    system './utils/autogen.sh'
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
