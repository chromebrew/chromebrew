require 'package'

class Libavif < Package
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  @_ver = '0.10.1'
  version @_ver.to_s
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/AOMediaCodec/libavif.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.10.1_armv7l/libavif-0.10.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.10.1_armv7l/libavif-0.10.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.10.1_i686/libavif-0.10.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.10.1_x86_64/libavif-0.10.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e85bb24abfff2cf9e3b0bf522a13db970f1bb79ffdf3687d27692a126ea0268d',
     armv7l: 'e85bb24abfff2cf9e3b0bf522a13db970f1bb79ffdf3687d27692a126ea0268d',
       i686: '19cb5215cbdfc6a7228d88cc6c2fcc2efd5f773a6ffe4ef92746a687c955c612',
     x86_64: 'f1bc86c59311063422da675683f701e25614414cde2fd8fdb52337865bf93f8b'
  })

  depends_on 'libaom'
  depends_on 'dav1d'
  depends_on 'rav1e'
  depends_on 'svt_av1' if ARCH == 'x86_64'
  depends_on 'libpng'
  depends_on 'libjpeg'
  depends_on 'libyuv'
  depends_on 'nasm' => :build
  depends_on 'pkgconf' => :build
  depends_on 'gdk_pixbuf' => :build

  def self.build
    ARCH == 'x86_64' ? (@svt = 'ON') : (@svt = 'OFF')

    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      # CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      # LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DAVIF_BUILD_APPS=ON \
        -DAVIF_CODEC_AOM=ON \
        -DAVIF_CODEC_DAV1D=ON \
        -DAVIF_CODEC_RAV1E=ON \
        -DAVIF_CODEC_SVT=#{@svt} \
        -DAVIF_BUILD_GDK_PIXBUF=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    if File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")
      system 'gdk-pixbuf-query-loaders',
             '--update-cache'
    end
  end
end
