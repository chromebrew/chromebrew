require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources'
  homepage 'http://www.stack.nl/~dimitri/doxygen/'
  version '1.8.13'
  source_url 'https://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.13.linux.bin.tar.gz'
  source_sha256 '1b3ceb3708c5099d51341cd4ac63893f05c736388f12fb99958081fc832a3b3e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'help2man'

  def self.build
    system "help2man -N bin/doxygen > doxygen.1"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp doxygen.1 #{CREW_DEST_PREFIX}/man/man1"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
