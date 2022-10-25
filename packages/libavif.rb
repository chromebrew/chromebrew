require 'package'

class Libavif < Package
  description 'Library for encoding and decoding .avif files'
  homepage 'https://github.com/AOMediaCodec/libavif'
  @_ver = '0.10.1'
  version "#{@_ver}-1"
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/AOMediaCodec/libavif.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.10.1-1_armv7l/libavif-0.10.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.10.1-1_armv7l/libavif-0.10.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.10.1-1_i686/libavif-0.10.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavif/0.10.1-1_x86_64/libavif-0.10.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6742660c503f4e1ac5f39e8b5e3c5ef04b064d5d01ab9b36ebf6c8d0d912db64',
     armv7l: '6742660c503f4e1ac5f39e8b5e3c5ef04b064d5d01ab9b36ebf6c8d0d912db64',
       i686: '88f3295861a9005e0dda42b4ffe1f7b9a5950fd5d024498aa009387fa4991639',
     x86_64: '5913a00db3f91eb5c64e95aa844ea6d7be2605b9e6244bb1dc640644ca1df634'
  })

  depends_on 'libaom'
  depends_on 'dav1d'
  depends_on 'rav1e'
  depends_on 'svt_av1'
  depends_on 'libpng'
  depends_on 'libjpeg'
  depends_on 'libyuv'
  depends_on 'nasm' => :build
  depends_on 'pkgconf' => :build
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DAVIF_BUILD_APPS=ON \
        -DAVIF_CODEC_AOM=ON \
        -DAVIF_CODEC_DAV1D=ON \
        -DAVIF_CODEC_RAV1E=ON \
        -DAVIF_CODEC_SVT=ON \
        -DAVIF_BUILD_GDK_PIXBUF=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    return unless File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")

    system 'gdk-pixbuf-query-loaders',
           '--update-cache'
  end
end
