require 'package'

class Bc < Package
  description 'bc is an arbitrary precision numeric processing language.'
  homepage 'http://www.gnu.org/software/bc/'
  version '1.07.1'
  source_url 'https://ftp.gnu.org/gnu/bc/bc-1.07.1.tar.gz'
  source_sha1 'b4475c6d66590a5911d30f9747361db47231640a'

  depends_on 'readline'
  depends_on 'flex' => :build
  depends_on 'ed' => :build

  def self.build
    system "./configure", "--with-readline"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
