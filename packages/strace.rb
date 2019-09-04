require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '5.2'
  source_url 'https://strace.io/files/5.2/strace-5.2.tar.xz'
  source_sha256 'd513bc085609a9afd64faf2ce71deb95b96faf46cd7bc86048bc655e4e4c24d2'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libunwind' # Better stack trace support

  def self.build
    system './configure',
           '--with-libunwind',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
