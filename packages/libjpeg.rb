require 'package'

class Libjpeg < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  @_ver = '2.1.4'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.4_armv7l/libjpeg-2.1.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.4_armv7l/libjpeg-2.1.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.4_i686/libjpeg-2.1.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.4_x86_64/libjpeg-2.1.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1de3b99b8a2ce0618e2538ad517d62b29a85f1938dca07c0570933b7f1f58313',
     armv7l: '1de3b99b8a2ce0618e2538ad517d62b29a85f1938dca07c0570933b7f1f58313',
       i686: 'e5b1f49cd89009289ebabb9cd2e76c3b000e49e8b752e376a8ef68e8b3c81b0d',
     x86_64: 'fec9fd92a2b02df0a9811ca75b64e1ee4ff34897ad8db83093506ea9f86bdae1'
  })

  depends_on 'yasm' => :build
  depends_on 'glibc' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DWITH_JAVA=OFF \
        -DWITH_12BIT=OFF \
        -W no-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.install 'jpegint.h', "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end
end
