require 'package'

class Libspatialindex < Package
  description 'C++ implementation of R*-tree, an MVR-tree and a TPR-tree with C API'
  homepage 'https://libspatialindex.org/'
  version '1.9.3'
  compatibility 'all'
  source_url 'https://github.com/libspatialindex/libspatialindex/archive/1.9.3.tar.gz'
  source_sha256 '7b44340a3edc55c11abfc453bb60f148b29f569cef9e1148583e76132e9c7379'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libspatialindex-1.9.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libspatialindex-1.9.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libspatialindex-1.9.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libspatialindex-1.9.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0b9b9ee6376b93b25ec8ac189df684a99a9951831ef985dbe3103d5af5d0c7c9',
     armv7l: '0b9b9ee6376b93b25ec8ac189df684a99a9951831ef985dbe3103d5af5d0c7c9',
       i686: '2d1b5785514e7ba09f09d2693ea8a916dedbc04fd55d6643685793fd7c645d02',
     x86_64: 'd42e7d8369a4ace82bfaa3638a42174e13b21db67248f2ca893908694e868cd7',
  })

  def self.build
    Dir.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} \
              .."
      system "ninja"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX if ARCH == 'x86_64'
  end
end
