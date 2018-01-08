require 'package'

class Entr < Package
  description 'Run arbitrary commands when files change'
  homepage 'http://entrproject.org/'
  version '3.9'
  source_url 'http://entrproject.org/code/entr-3.9.tar.gz'
  source_sha256 '02d78f18ae530e64bfbb9d8e0250962f85946e10850dd065899d03af15f26876'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'cp Makefile.linux Makefile'
    system "PREFIX=#{CREW_PREFIX} make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
