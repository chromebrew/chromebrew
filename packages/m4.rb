require 'package'

class M4 < Package
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.18'
  source_url 'https://ftp.gnu.org/gnu/m4/m4-1.4.18.tar.xz'
  source_sha1 '228604686ca23f42e48b98930babeb5d217f1899'

  depends_on 'libsigsegv'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make check"
  end
end
