require 'package'

class Libaom < Package
  description 'AV1 video codec from Alliance for Open Media'
  homepage 'https://aomedia.org/'
  version '1.0.0'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libaom-1.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libaom-1.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libaom-1.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libaom-1.0.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '333119009f00f96ab6fda4ea900eb19bf81bd8c446775d6b073a4ac56a0d2066',
     armv7l: '333119009f00f96ab6fda4ea900eb19bf81bd8c446775d6b073a4ac56a0d2066',
       i686: 'cdece1990fc30a8f45847ae13aa2e6dab6f9321365bb9412283d00586f23489f',
     x86_64: 'c7bb9de577e4ff32458c47d9bf2c3a329a6011368f3f3bbde8e072fd9530d5c8'
  })

  depends_on 'yasm' => ':build'

  def self.prebuild
    @git_dir = 'aom_git'
    @git_hash = '8b6eaa4d37b992efffe432fa513889e6d11ae04f'
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
