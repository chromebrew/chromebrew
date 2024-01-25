require 'package'

class Libvpx < Package
  description 'VP8/VP9 Codec SDK'
  homepage 'http://www.webmproject.org/code/'
  version '1.13.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/webm/libvpx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32f4ebce8271fc686b711bc48d601077c07a510a9e68b5c4aa6faa3ae85bd4a3',
     armv7l: '32f4ebce8271fc686b711bc48d601077c07a510a9e68b5c4aa6faa3ae85bd4a3',
       i686: 'ebdfb3a4e7567d6e359935d8e24d28bdf4533ea119c5d70f6716f2c74aa7b07f',
     x86_64: 'ef9b3e27b231f7546402442a04489b53aa8724c396dcbc6abc4e43b8a32080cd'
  })

  depends_on 'ccache' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libyuv' => :build
  depends_on 'yasm' => :build

  def self.build
    Dir.chdir 'build' do
      system "../configure #{CREW_OPTIONS.sub(/--mandir=.*/, '')} \
        --disable-debug-libs \
        --disable-install-docs \
        --enable-ccache \
        --enable-libyuv \
        --enable-pic \
        --enable-runtime-cpu-detect \
        --enable-shared \
        --enable-vp8 \
        --enable-vp9 \
        --enable-vp9-highbitdepth"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
