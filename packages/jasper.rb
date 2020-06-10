require 'package'

class Jasper < Package
  description 'The JasPer Project is an open-source initiative to provide a free software-based reference implementation of the codec specified in the JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1).'
  homepage 'http://www.ece.uvic.ca/~frodo/jasper/'
  version '2.0.16'
  compatibility 'all'
  source_url 'https://github.com/mdadams/jasper/archive/version-2.0.16.tar.gz'
  source_sha256 'f1d8b90f231184d99968f361884e2054a1714fdbbd9944ba1ae4ebdcc9bbfdb1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jasper-2.0.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jasper-2.0.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jasper-2.0.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jasper-2.0.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f6930f4eb532697e9a8b2ba0c124b78d7ed20e38d376d8b7f6f04fb67aa5002a',
     armv7l: 'f6930f4eb532697e9a8b2ba0c124b78d7ed20e38d376d8b7f6f04fb67aa5002a',
       i686: '4c37b7d767f66147d703ff8cf28cfd53e9e18da14a93afc48af3c8996c781786',
     x86_64: 'e955f0bda71b3dd685ccab2d92edebf640ef3052bca025e737092275de116848',
  })

  depends_on 'ld_default' => :build
  depends_on 'shared_mime_info'
  depends_on 'freeglut'
  depends_on 'mesa'

  def self.build
    puts 'Change to GOLD linker.'.orange
    original_default = `ld_default g`.chomp
    system 'cmake', '-G', 'Unix Makefiles', '-H.', '-Bbuild',
           "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
           '-DCMAKE_BUILD_TYPE=Release',
           '-DJAS_ENABLE_DOC=FALSE'
    Dir.chdir 'build' do
      system 'make clean all'
    end
    system "ld_default #{original_default}"
  end

  def self.check
    Dir.chdir 'build' do
#      system 'make test'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
