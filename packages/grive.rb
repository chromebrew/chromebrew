require 'package'

class Grive < Package
  description 'Google Drive client with support for new Drive REST API and partial sync'
  homepage 'https://github.com/vitalif/grive2'
  version '0.5.3-648ff8e'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/vitalif/grive2.git'
  git_hashtag '648ff8eea1a3c7cac8bfba283f75717bf54c67eb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.3-648ff8e_armv7l/grive-0.5.3-648ff8e-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.3-648ff8e_armv7l/grive-0.5.3-648ff8e-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.3-648ff8e_i686/grive-0.5.3-648ff8e-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grive/0.5.3-648ff8e_x86_64/grive-0.5.3-648ff8e-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f20f7a15dbdc514af123edc914c2ca63b2f5327b1161d5aa981e182654608b4a',
     armv7l: 'f20f7a15dbdc514af123edc914c2ca63b2f5327b1161d5aa981e182654608b4a',
       i686: '7f263c2999dccd40fff6955bf6601a37bfcc1ce7c403ccd210de23151119cafd',
     x86_64: '85e04905425f8e2ab8b6a9843032af15a781aa2c5446e12fbd4444b36c18f5ea'
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
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
