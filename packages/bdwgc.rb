require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collector'
  homepage 'https://github.com/ivmai/bdwgc'
  version '8.0.4'
  source_url 'https://github.com/ivmai/bdwgc/releases/download/v8.0.4/gc-8.0.4.tar.gz'
  source_sha256 '436a0ddc67b1ac0b0405b61a9675bca9e075c8156f4debd1d06f3a56c7cd289d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libatomic_ops'

  def self.build
    system './configure',
           '--enable-mmap',
           '--enable-shared',
           '--disable-static',
           '--enable-cplusplus',
           '--enable-handle-fork',
           "--prefix=#{CREW_PREFIX}",
           '--enable-redirect-malloc',
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
