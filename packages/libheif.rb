require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  @_ver = '1.16.2'
  version @_ver
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.16.2_armv7l/libheif-1.16.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.16.2_armv7l/libheif-1.16.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.16.2_x86_64/libheif-1.16.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4f8c58cd76e80fb068037384b9df97d32fe2053ccc8694548a6826118ea08d43',
     armv7l: '4f8c58cd76e80fb068037384b9df97d32fe2053ccc8694548a6826118ea08d43',
     x86_64: '77b620b3b7bf687577ab36fd88098aaa85ffe930fa71a7a342776b4d555f8f24'
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
  depends_on 'libwebp' # R
  depends_on 'libx265' # R
  depends_on 'rav1e' # R
  depends_on 'svt_av1' # R
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
