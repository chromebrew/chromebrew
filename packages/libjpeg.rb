require 'package'

class Libjpeg < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '2.1.5.1'
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.5.1_armv7l/libjpeg-2.1.5.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.5.1_armv7l/libjpeg-2.1.5.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.5.1_i686/libjpeg-2.1.5.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.5.1_x86_64/libjpeg-2.1.5.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '22e4475d2ff367b21b6608dfaadeab459957bf385df26f768309844223151c73',
     armv7l: '22e4475d2ff367b21b6608dfaadeab459957bf385df26f768309844223151c73',
       i686: 'b2ec21bc91a53d4d74640804a47c4d95d34f7f490c25f7134cc27cd18bcfcd48',
     x86_64: '31c1dd4a5cf956c9552ca480aa67ed7c0c89ce0cbeaf2f807975f523a79509d1'
  })

  depends_on 'yasm' => :build
  depends_on 'glibc' # R

  def self.build
    system "cmake \
        -B builddir -G Ninja \
        #{CREW_CMAKE_OPTIONS.gsub('-mfpu=vfpv3-d16', '-mfpu=neon-fp16')} \
        -DENABLE_STATIC=OFF \
        -DWITH_12BIT=OFF \
        -DWITH_JAVA=OFF \
        -W no-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.install 'jpegint.h', "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end
end
