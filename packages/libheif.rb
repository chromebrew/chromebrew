require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  @_ver = '1.13.0'
  version @_ver
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
       i686: 'c18a1d2960a9e67047f23389fc53c22a18fe13fc56b61a1bad1eba6970d24c48',
     x86_64: '626d99ad78adb2e959bc0cf812ce53da110d79d3917378b110b914f545137660'
  })

  depends_on 'dav1d' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libaom' # R
  depends_on 'libde265' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # L
  depends_on 'libx265' # R
  depends_on 'rav1e' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "cmake -B builddir \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
