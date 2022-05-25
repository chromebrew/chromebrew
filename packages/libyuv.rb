require 'package'

class Libyuv < Package
  description 'Library for YUV scaling'
  homepage 'https://chromium.googlesource.com/libyuv/libyuv/'
  version 'd47031c'
  license 'BSD-Google'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/libyuv/libyuv.git'
  git_hashtag 'd47031c0d42efa8f10842e36f7b8135b52bcd3d0'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libyuv/d47031c_armv7l/libyuv-d47031c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libyuv/d47031c_armv7l/libyuv-d47031c-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libyuv/d47031c_i686/libyuv-d47031c-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libyuv/d47031c_x86_64/libyuv-d47031c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '18ea1ea4d78c74d225a5bf5a7ca1d4f188688907ce4603c5e63e28c32ea6f2bc',
     armv7l: '18ea1ea4d78c74d225a5bf5a7ca1d4f188688907ce4603c5e63e28c32ea6f2bc',
       i686: '286acb3983d5b3771e3dc3711946166b054fbf8c2cd6febc52d2fe4286e6b5eb',
     x86_64: '74f2df52cec84b0879235e2db0b6c831518692ffc20deb3e2e2b55e60de55e48'
  })

  depends_on 'libjpeg'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    Dir.chdir CREW_DEST_PREFIX do
      FileUtils.mv 'lib', 'lib64' if ARCH == 'x86_64'
    end
  end
end
