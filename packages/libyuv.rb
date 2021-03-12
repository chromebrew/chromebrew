require 'package'

class Libyuv < Package
  description 'Library for YUV scaling'
  homepage 'https://chromium.googlesource.com/libyuv/libyuv/'
  version 'd470'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libyuv-d470-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libyuv-d470-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libyuv-d470-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libyuv-d470-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7fa394f0b0e7da7ccb54fa49dd04ee1fc794eee1518c6a9a39743ab006ca7dd0',
     armv7l: '7fa394f0b0e7da7ccb54fa49dd04ee1fc794eee1518c6a9a39743ab006ca7dd0',
       i686: '15f7bb558997c8a437997d61aa7a16aed327a87cf50e0d7504373ba9b6796c79',
     x86_64: 'e4a3761380386ef8fa07c95b195eedfd4cae05616d5ee3af4e55ae761010efff'
  })

  depends_on 'libjpeg'

  def self.prebuild
    @git_dir = 'libyuv_git'
    @git_hash = 'd47031c0d42efa8f10842e36f7b8135b52bcd3d0'
    @git_url = 'https://chromium.googlesource.com/libyuv/libyuv'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
  end

  def self.build
    Dir.mkdir 'libyuv_git/builddir'
    Dir.chdir 'libyuv_git/builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C libyuv_git/builddir'
    system 'du -a libyuv_git/builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C libyuv_git/builddir install"
    Dir.chdir CREW_DEST_PREFIX do
      FileUtils.mv 'lib', 'lib64' if ARCH == 'x86_64'
    end
  end
end
