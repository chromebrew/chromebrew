require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  @_ver = '1.13.0'
  version @_ver.to_s
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.13.0_armv7l/libheif-1.13.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.13.0_armv7l/libheif-1.13.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.13.0_i686/libheif-1.13.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.13.0_x86_64/libheif-1.13.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54aac0957aeddde47d7a2b85c9bab3930314203cdc9d5fcfa8adbcc09d0e2eee',
     armv7l: '54aac0957aeddde47d7a2b85c9bab3930314203cdc9d5fcfa8adbcc09d0e2eee',
       i686: 'e9ef19612c0c6fd85fe169c97b994ec31f1604e3ebdb9b2547fb18ac1adde6e5',
     x86_64: '65f4fda223012e0ed5ead49c7b4cf36662bbe7f0745fc34b68124dd87a54fdeb'
  })

  depends_on 'dav1d'
  depends_on 'libaom'
  depends_on 'libde265'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libx265'
  depends_on 'rav1e'
  depends_on 'gdk_pixbuf' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
