require 'package'

class Libspng < Package
  description 'libspng is a C library for reading and writing Portable Network Graphics (PNG) format files with a focus on security and ease of use.'
  homepage 'https://libspng.org'
  version '0.5.0'
  compatibility 'all'
  source_url 'https://gitlab.com/randy408/libspng/uploads/3d980bac86c51368f40af2f1ac79a057/libspng-0.5.0.tar.xz'
  source_sha256 '220a653802559943ae43fd48f03ba6ff3935a5243766d9ee5ff905240d4399a7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libspng-0.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libspng-0.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libspng-0.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libspng-0.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '269f399358a4f7f3d9f8756f3e437b1c9c055d3b3632e802a28a3b0673553e39',
     armv7l: '269f399358a4f7f3d9f8756f3e437b1c9c055d3b3632e802a28a3b0673553e39',
       i686: '0abff0a70f0ae1e4b66185248857aa2485b6d29ec2265d53a2df5cfbacab2b22',
     x86_64: '4ffaad2bcca5bfca6034670ddbbc6bf6cea078bb587488e511225e75d9901067',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir('build') do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} .."
      system "sed -i 's,build\/tests\/libspng\.pc,build\/libspng.pc,' cmake_install.cmake"
      system 'make'
    end
  end

  def self.install
    Dir.chdir('build') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      FileUtils.mv "#{CREW_DEST_PREFIX}/lib/libspng.so", "#{CREW_DEST_LIB_PREFIX}/libspng.so" if ARCH == 'x86_64'
    end
  end
end
