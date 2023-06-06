require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.3.0-fd7b5d4'
  license 'BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/webmproject/libwebp.git'
  git_hashtag 'fd7b5d48464475408d32d2611bdb6947d4246b97'

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.3.0_i686/libwebp-1.3.0-chromeos-i686.tar.zst',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.3.0-fd7b5d4_armv7l/libwebp-1.3.0-fd7b5d4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.3.0-fd7b5d4_armv7l/libwebp-1.3.0-fd7b5d4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libwebp/1.3.0-fd7b5d4_x86_64/libwebp-1.3.0-fd7b5d4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
       i686: '036924f4f26489260fc49d8cbc4656c4a23b8d6c936cc71f96cd59880e650c75',
    aarch64: '9f84e3dc4e65c702fd32fbde197aa1055b97466c883f88a7278eee3babca5782',
     armv7l: '9f84e3dc4e65c702fd32fbde197aa1055b97466c883f88a7278eee3babca5782',
     x86_64: '58dddc123cc887299f845b7800b8289f0ea274576980b8861f20c70bdc158256'
  })

  depends_on 'freeglut' # R
  depends_on 'gcc_lib' # R
  depends_on 'giflib' # R
  depends_on 'glibc' # R
  depends_on 'jbigkit' # R
  depends_on 'libdeflate' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libsdl' => :build
  depends_on 'libsm' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxi' # R
  depends_on 'libxmu' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system "cmake \
      -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
      -DBUILD_SHARED_LIBS=ON \
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
