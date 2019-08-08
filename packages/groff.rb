require 'package'

class Groff < Package
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.22.4'
  source_url 'https://ftp.gnu.org/gnu/groff/groff-1.22.4.tar.gz'
  source_sha256 'e78e7b4cb7dec310849004fa88847c44701e8d133b5d4c13057d876c1bad0293'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'perl'

  def self.build
    system 'INSTALL_PROGRAM=\'${INSTALL} -s\' ./configure'

    # force to compile in sequential since groff Makefile doesn't work in parallel
    system 'make', '-j1'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
