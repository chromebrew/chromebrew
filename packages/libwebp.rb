require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.3.0'
  license 'BSD'
  compatibility 'all'
  source_url 'http://downloads.webmproject.org/releases/webp/libwebp-1.3.0.tar.gz'
  source_sha256 '64ac4614db292ae8c5aa26de0295bf1623dbb3985054cb656c55e67431def17c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.3.0_armv7l/libwebp-1.3.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.3.0_armv7l/libwebp-1.3.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.3.0_i686/libwebp-1.3.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.3.0_x86_64/libwebp-1.3.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b53467584541660e2868e195e380b4f489a2a1bc3547705ad918dbebda3486e5',
     armv7l: 'b53467584541660e2868e195e380b4f489a2a1bc3547705ad918dbebda3486e5',
       i686: '036924f4f26489260fc49d8cbc4656c4a23b8d6c936cc71f96cd59880e650c75',
     x86_64: '8568b43bcc23bc5686354a67b654cb18c4dfe6560637c43ce8b8f9eef5b76580'
  })

  depends_on 'freeglut' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'jbigkit' => :build
  depends_on 'libdeflate' # R
  depends_on 'libglvnd' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libsdl' => :build unless ARCH == 'i686'
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
