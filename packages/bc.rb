require 'package'

class Bc < Package
  description 'bc is an arbitrary precision numeric processing language.'
  homepage 'http://www.gnu.org/software/bc/'
  version '1.07.1'
  source_url 'https://ftp.gnu.org/gnu/bc/bc-1.07.1.tar.gz'
  source_sha256 '62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a'

  depends_on 'readline'
  depends_on 'flex'
  depends_on 'ed' => :build
  depends_on 'texinfo' => :build

  def self.build
    system "./configure", "--with-readline"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
