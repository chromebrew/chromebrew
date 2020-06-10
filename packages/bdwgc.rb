require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collector'
  homepage 'https://github.com/ivmai/bdwgc'
  version '8.0.4'
  compatibility 'all'
  source_url 'https://github.com/ivmai/bdwgc/releases/download/v8.0.4/gc-8.0.4.tar.gz'
  source_sha256 '436a0ddc67b1ac0b0405b61a9675bca9e075c8156f4debd1d06f3a56c7cd289d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-8.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-8.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-8.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-8.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '876731fcfc8923fb084dceaed37bb98c6a74db13b526b38a3b3b6fa8dd5393c9',
     armv7l: '876731fcfc8923fb084dceaed37bb98c6a74db13b526b38a3b3b6fa8dd5393c9',
       i686: 'be933d4e732ba200b3c3c0bea9c163552cabe118d157d02b713e21dbc896eac2',
     x86_64: '3195a44840152f6e67ca5f8f27118186af4422d7ab145e0276aa0af4dfd84378',
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
