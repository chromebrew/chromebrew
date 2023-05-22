require 'package'

class Doxygen < Package
  description 'Doxygen is the de facto standard tool for generating documentation from annotated C++ sources, but it also supports other popular programming languages such as C, Objective-C, C#, PHP, Java, Python, IDL (Corba, Microsoft, and UNO/OpenOffice flavors), Fortran, VHDL, Tcl, and to some extent D.'
  homepage 'http://www.doxygen.nl/'
  version '1.9.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/doxygen/doxygen/archive/Release_1_9_7.tar.gz'
  source_sha256 '691777992a7240ed1f822a5c2ff2c4273b57c1cf9fc143553d87f91a0c5970ee'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.7_armv7l/doxygen-1.9.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.7_armv7l/doxygen-1.9.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.7_i686/doxygen-1.9.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/doxygen/1.9.7_x86_64/doxygen-1.9.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6d4833b7b1a11da5e296ccc42b1e1160c0f82a352e530a0d5fb089d2579e1c4c',
     armv7l: '6d4833b7b1a11da5e296ccc42b1e1160c0f82a352e530a0d5fb089d2579e1c4c',
       i686: '7e361e8ee99288f285e6fe5eab63bb1319f86b465471ee39981f899920a46fe3',
     x86_64: 'e4e7a0f6ffd124d55edd4e0a8534604d4601016ffdabe8531fba1c39be38066f'
  })

  depends_on 'python3' => :build

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake -G Ninja \
            #{CREW_CMAKE_OPTIONS} \
            .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
