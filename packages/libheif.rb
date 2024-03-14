require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  version '1.17.6'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/strukturag/libheif.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '153437667ebd49391e11d549fcb771c9f15fbba8baa361fdaded872ee5206e01',
     armv7l: '153437667ebd49391e11d549fcb771c9f15fbba8baa361fdaded872ee5206e01',
     x86_64: 'ec98371ae67cc1c03f79638f7df0490d094c56eb3514576d2c0b53da8400b7cc'
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

  gnome

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
end
