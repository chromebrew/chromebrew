require 'package'

class Libspng < Package
  description 'libspng is a C library for reading and writing Portable Network Graphics (PNG) format files with a focus on security and ease of use.'
  homepage 'https://libspng.org'
  version '0.5.0'
  source_url 'https://gitlab.com/randy408/libspng/uploads/3d980bac86c51368f40af2f1ac79a057/libspng-0.5.0.tar.xz'
  source_sha256 '220a653802559943ae43fd48f03ba6ff3935a5243766d9ee5ff905240d4399a7'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build
  depends_on 'zlibpkg'

  def self.build
    system 'mkdir -p build'
    Dir.chdir('build') do
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} .."
      system "sed -i 's,build\/tests\/libspng\.pc,build\/libspng.pc,' cmake_install.cmake"
      system 'make'
    end
  end

  def self.install
    Dir.chdir('build') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
