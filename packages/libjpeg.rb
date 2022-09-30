require 'package'

class Libjpeg < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  @_ver = '2.1.4'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/libjpeg-turbo/libjpeg-turbo.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.4_armv7l/libjpeg-2.1.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.4_armv7l/libjpeg-2.1.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.4_i686/libjpeg-2.1.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/2.1.4_x86_64/libjpeg-2.1.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1fba7f42a0d3c92531f19c7c53ca9a959ce8de00a967a62ab408a1712726978a',
     armv7l: '1fba7f42a0d3c92531f19c7c53ca9a959ce8de00a967a62ab408a1712726978a',
       i686: '709ae3ba9e425a48a9b964b844a2fa3b18d4187eb17174501b77286565226bdd',
     x86_64: '70f57ca8937bfeb6d48be10fcd8cf70dc64a8aa1266d9a8793d1759aa1e76ead'
  })

  git_hashtag @_ver

  depends_on 'yasm' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DWITH_JPEG8=1 \
        -DWITH_JAVA=OFF \
        -DWITH_12BIT=ON \
        -W no-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.check
    # This fails on i686.
    system 'ninja -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.install 'jpegint.h', "#{CREW_DEST_PREFIX}/include/", mode: 0o644
  end
end
