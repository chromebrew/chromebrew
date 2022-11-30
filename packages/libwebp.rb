require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.2.4'
  license 'BSD'
  compatibility 'all'
  source_url 'http://downloads.webmproject.org/releases/webp/libwebp-1.2.4.tar.gz'
  source_sha256 '7bf5a8a28cc69bcfa8cb214f2c3095703c6b73ac5fba4d5480c205331d9494df'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.2.4_armv7l/libwebp-1.2.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.2.4_armv7l/libwebp-1.2.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.2.4_i686/libwebp-1.2.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.2.4_x86_64/libwebp-1.2.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a2e7a4256e82a504e6743fbe60f00392454d372cd7dc49bdb6048d7ad38f295e',
     armv7l: 'a2e7a4256e82a504e6743fbe60f00392454d372cd7dc49bdb6048d7ad38f295e',
       i686: 'e7a0d7cdce843ec6fdfb4777cea92c4a86e788db276c323ca2509444411cc064',
     x86_64: '1abbb91a453ce229b295d6a1383799bc7a1898140d711b866f13a69ea9d318da'
  })

  depends_on 'freeglut' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'libdeflate' # R
  depends_on 'libglvnd' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libsdl' => :build
  depends_on 'libtiff' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --enable-libwebpmux \
      --enable-libwebpdemux \
      --enable-libwebpdecoder \
      --enable-libwebpextras \
      --enable-sdl \
      --enable-tiff \
      --enable-jpeg \
      --enable-png \
      --enable-gif"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
