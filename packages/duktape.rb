require 'package'

class Duktape < Package
  description 'Embeddable Javascript engine'
  homepage 'https://duktape.org/'
  version '2.7.0-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/svaarala/duktape-releases.git'
  git_hashtag 'v2.7.0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f140a0f226f7d1c91bdf22b92a16bfecbebf401bfc79165a324191ea35b46a3a',
     armv7l: 'f140a0f226f7d1c91bdf22b92a16bfecbebf401bfc79165a324191ea35b46a3a',
       i686: '535d51c28caab852609ac4983cc4c4d25e15208e41851606d319f4f49edb0430',
     x86_64: '7a39e108b1168a7ac69fe164b43a79065be5b4832ff5d4a31a6762c41a069b3c'
  })

  depends_on 'glibc' # R
  depends_on 'setconf' => :build

  def self.build
    system "INSTALL_PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} make -f Makefile.sharedlibrary"
  end

  def self.install
    system "INSTALL_PREFIX= LIBDIR=/#{ARCH_LIB} DESTDIR=#{CREW_DEST_PREFIX} make -f Makefile.sharedlibrary install"
  end
end
