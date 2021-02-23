require 'package'

class Libspatialindex < Package
  description 'C++ implementation of R*-tree, an MVR-tree and a TPR-tree with C API'
  homepage 'https://libspatialindex.org/'
  version '1.9.3'
  compatibility 'all'
  source_url 'https://github.com/libspatialindex/libspatialindex/archive/1.9.3.tar.gz'
  source_sha256 '7b44340a3edc55c11abfc453bb60f148b29f569cef9e1148583e76132e9c7379'

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
  end
end
