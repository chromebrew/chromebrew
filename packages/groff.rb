require 'package'

class Groff < Package
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.22.4'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/groff/groff-1.22.4.tar.gz'
  source_sha256 'e78e7b4cb7dec310849004fa88847c44701e8d133b5d4c13057d876c1bad0293'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/groff-1.22.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/groff-1.22.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/groff-1.22.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/groff-1.22.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7e64b76b272bc182c6525c7eef2c46515a34a8a5f4c5baa98232e5a89fcf01b1',
     armv7l: '7e64b76b272bc182c6525c7eef2c46515a34a8a5f4c5baa98232e5a89fcf01b1',
       i686: '6e0ff314086dfd363f162cc1f397eda4777391de0052566a1494aac62be23aa7',
     x86_64: '3f3bf23656ec19567fab24646361569c2e42f8273e473b229eb5800ea53d1d30',
  })

  depends_on 'uchardet'

  def self.build
    system 'INSTALL_PROGRAM=\'${INSTALL} -s\' ./configure'

    # force to compile in sequential since groff Makefile doesn't work in parallel
    system 'make', '-j1'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    #system "make", "check"
  end
end
