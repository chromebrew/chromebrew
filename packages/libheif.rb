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
    aarch64: '7da1e2d572c75cfaa81420b0e170c77118f02a6a5ce241b3e095412638f72866',
     armv7l: '7da1e2d572c75cfaa81420b0e170c77118f02a6a5ce241b3e095412638f72866',
     x86_64: 'ab72439e8517ea668c55d8c2401353c81e8a9a5e0689929b8d14864cb7c05de4'
  })

  depends_on 'dav1d' # R
  depends_on 'gcc_lib' # R
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
        #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
        -Wno-dev"
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
