require 'package'

class Ccache < Package
  description 'Compiler cache that speeds up recompilation by caching previous compilations'
  homepage 'https://ccache.samba.org/'
  version '4.1'
  compatibility 'all'
  source_url 'https://github.com/ccache/ccache/releases/download/v4.1/ccache-4.1.tar.xz'
  source_sha256 '5fdc804056632d722a1182e15386696f0ea6c59cb4ab4d65a54f0b269ae86f99'

  binary_url ({
     aarch64: 'file:///usr/local/tmp/packages/ccache-4.1-chromeos-armv7l.tar.xz',
      armv7l: 'file:///usr/local/tmp/packages/ccache-4.1-chromeos-armv7l.tar.xz',
        i686: 'file:///usr/local/tmp/packages/ccache-4.1-chromeos-i686.tar.xz',
      x86_64: 'file:///usr/local/tmp/packages/ccache-4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '525bce425116fadb8ffaf352df87bde4f424380a1d4a98915d52de005aa0663d',
      armv7l: '525bce425116fadb8ffaf352df87bde4f424380a1d4a98915d52de005aa0663d',
        i686: '14ebe59db9eb33c86f867153bda9340fa5732a2ad19f48fe0e8900f238b43015',
      x86_64: '5c4c9e014f23977f2f031eb9f9b367881a20fa8effeac9e38289cd723aa11e62',
  })





  depends_on 'zlibpkg'
  depends_on 'asciidoc' => :build

  def self.build
  ENV['CFLAGS'] = '-flto'
  ENV['CXXFLAGS'] = '-flto'
  Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
      -DZSTD_FROM_INTERNET=ON \
      .."
      system "ninja"
    end
  end
  
  def self.install
  system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    Dir.chdir 'build' do
      FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/ccache/bin"
      system "for _prog in gcc g++ c++; do
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/$_prog 
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/${CHOST}-$_prog
      done
      for _prog in cc clang clang++; do
        ln -s #{CREW_PREFIX}/bin/ccache #{CREW_DEST_LIB_PREFIX}/ccache/bin/$_prog
      done"
    end
  end
  
  def self.postinstall
      system "ccache --set-config=sloppiness=file_macro,locale,time_macros"
  end
end
