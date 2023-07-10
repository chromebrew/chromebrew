require 'package'

class Grive < Package
  description 'Google Drive client with support for new Drive REST API and partial sync'
  homepage 'https://github.com/vitalif/grive2'
  version '0.5.3-648ff8e-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vitalif/grive2.git'
  git_hashtag '648ff8eea1a3c7cac8bfba283f75717bf54c67eb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.3-648ff8e-1_armv7l/grive-0.5.3-648ff8e-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.3-648ff8e-1_armv7l/grive-0.5.3-648ff8e-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.3-648ff8e-1_i686/grive-0.5.3-648ff8e-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.3-648ff8e-1_x86_64/grive-0.5.3-648ff8e-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '65b144b2b0fd75508d0eefa17e85bfdf23543cfbfba6f76e03be05bd755861ce',
     armv7l: '65b144b2b0fd75508d0eefa17e85bfdf23543cfbfba6f76e03be05bd755861ce',
       i686: 'b79595e51ff95f77d8cc509d4e2e569f7ac42f63135aa7c9677e54dbe28adbd8',
     x86_64: '339c28ec20a87c0a51d4ebe32c7606d50cc92b56dce27b996341e74ab210433e'
  })

  depends_on 'binutils' # R
  depends_on 'boost' # R
  depends_on 'cppunit' => :build
  depends_on 'expat' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'curl' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpgerror' # R
  depends_on 'yajl' # R

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -G Ninja"
    system "#{CREW_NINJA} -C builddir || ( sed -i 's/-fno-lto//g' builddir/libgrive/build.ninja && #{CREW_NINJA} -C builddir)"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
