require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  @_ver = '1.15.1'
  version @_ver
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.15.1_armv7l/libheif-1.15.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.15.1_armv7l/libheif-1.15.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.15.1_i686/libheif-1.15.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.15.1_x86_64/libheif-1.15.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ba384b24e42ff1198b62cf6d58d90f0e10c758654d2a2efd3172e983997b88e0',
     armv7l: 'ba384b24e42ff1198b62cf6d58d90f0e10c758654d2a2efd3172e983997b88e0',
       i686: 'f605879bcb28e7d13b95f2116f180950e5f6889cba5c37172b3505e3deac2bcf',
     x86_64: 'd017e2cbfdc71a68b7ee56f0ec473ad26c3ed330abb3ecb3d0864aed315cd539'
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
  depends_on 'svt_av1' # R

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
