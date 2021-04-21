require 'package'

class Libaom < Package
  description 'AV1 video codec from Alliance for Open Media'
  homepage 'https://aomedia.org/'
  version '3.0.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libaom-3.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/libaom-3.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/libaom-3.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/libaom-3.0.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '72f877cc765100e7fcde222405861a42c9193d715fb2c068854ad4caf9d2d48c',
     armv7l: '72f877cc765100e7fcde222405861a42c9193d715fb2c068854ad4caf9d2d48c',
       i686: 'a73111242ed76bf16ec0c638095ef304437e1330ae489108153e43eec5fc3a85',
     x86_64: 'aae749ceebb4a126c85f80c2864253d8377893d225d26045e6838f7cb35a1cbe'
  })

  depends_on 'yasm' => :build

  def self.prebuild
    @git_dir = 'aom_git'
    @git_hash = '307ce06ed82d93885ee8ed53e152c9268ac0d98d'
    @git_url = 'https://aomedia.googlesource.com/aom'
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
    Dir.mkdir 'aom_git/builddir'
    Dir.chdir 'aom_git/builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS:BOOL='ON' \
        -DCMAKE_COLOR_MAKEFILE:BOOL='ON' \
        -DENABLE_CCACHE:BOOL='OFF' \
        -DENABLE_DECODE_PERF_TESTS:BOOL='OFF' \
        -DENABLE_EXAMPLES:BOOL='ON' \
        -DENABLE_DISTCC:BOOL='OFF' \
        -DENABLE_DOCS:BOOL='ON' \
        -DENABLE_GOMA:BOOL='OFF' \
        -DENABLE_NASM:BOOL='ON' \
        -DENABLE_TESTS:BOOL='OFF' \
        -DENABLE_TOOLS:BOOL='ON' \
        -DENABLE_WERROR:BOOL='OFF' \
        -DINCLUDE_INSTALL_DIR:PATH='#{CREW_PREFIX}/include' \
        -DLIB_INSTALL_DIR:PATH='#{CREW_LIB_PREFIX}' \
        -Wno-dev \
        .."
    end
    system 'ninja -C aom_git/builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C aom_git/builddir install"
  end
end
