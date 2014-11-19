require 'package'

class Clisp < Package
  version '2.49'
  source_url 'ftp://ftp.gnu.org/pub/gnu/clisp/release/2.49/clisp-2.49.tar.bz2'
  source_sha1 '7e8d585ef8d0d6349ffe581d1ac08681e6e670d4'

  depends_on 'libsigsegv'
  depends_on 'ffcall'

  def self.build
    system "./configure CC=\"gcc -m64\" CFLAGS=\" -fPIC\""
    FileUtils.cd('src') do
      system "ulimit -s 16384"
      system "make"
    end
  end

  def self.install
    FileUtils.cd('src') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
