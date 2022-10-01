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
    aarch64: 'd39d4cd84f6f74d8ba924abe75cb3e06ea1320dc5ba3a2f589cb901fdd6ee512',
     armv7l: 'd39d4cd84f6f74d8ba924abe75cb3e06ea1320dc5ba3a2f589cb901fdd6ee512',
       i686: '66680c86bd795d5b1f9a20507488de6a50864bb38cbe254041df05bd00e8734e',
     x86_64: '0eb3ac754a8de4a60cbd030d81d93255eae501f0e03360b56cc2af00818659a7'
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
  depends_on 'gdk_pixbuf' => :build

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
