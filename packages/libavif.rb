require 'package'

class Libavif < Package
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  @_ver = '0.11.1'
  version @_ver
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/AOMediaCodec/libavif.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.11.1_armv7l/libavif-0.11.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.11.1_armv7l/libavif-0.11.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.11.1_i686/libavif-0.11.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.11.1_x86_64/libavif-0.11.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9c5152797b36c3da157ac4e43ba462617fe4c173f0dfda6ffc3f2f83250e8a06',
     armv7l: '9c5152797b36c3da157ac4e43ba462617fe4c173f0dfda6ffc3f2f83250e8a06',
       i686: '970d2f65e8dac8eaec92c0847deeb5aa25d557bebddc904bdc60f968e135e484',
     x86_64: 'd8473a785ecd42c53652973068f65c3462114539339194937e36e3e9301127ec'
  })

  depends_on 'dav1d' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libaom' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # L
  depends_on 'libyuv' # R
  depends_on 'nasm' => :build
  depends_on 'pandoc' => :build
  depends_on 'pkgconf' => :build
  depends_on 'rav1e' # R
  depends_on 'svt_av1' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "cmake -B builddir \
      -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DAVIF_BUILD_APPS=ON \
      -DAVIF_CODEC_AOM=ON \
      -DAVIF_CODEC_DAV1D=ON \
      -DAVIF_CODEC_RAV1E=ON \
      -DAVIF_CODEC_SVT=ON \
      -DAVIF_BUILD_GDK_PIXBUF=ON \
      -DAVIF_BUILD_MAN_PAGES=ON"
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
