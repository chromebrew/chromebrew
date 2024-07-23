require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version '2.6-6f6bb13'
  license 'LGPL-2.1 and GPL-2'
  compatibility 'all'
  source_url 'https://git.ffmpeg.org/rtmpdump.git'
  git_hashtag '6f6bb1353fc84f4cc37138baa99f586750028a01'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ac0bf695f1cf627cc9e2cdf99fb8a0ad3058360b5c46d25114c357ae7b48757',
     armv7l: '3ac0bf695f1cf627cc9e2cdf99fb8a0ad3058360b5c46d25114c357ae7b48757',
       i686: 'b033b0cd2ab34aa95548f370e5aed5cb3be372ab298910fc3cfd7629c8690f5f',
     x86_64: '76b21d71603c2e7185c85e382c1a472b9cd949152034b6d113898a3ab33fb7e9'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'nettle' # R
  depends_on 'zlibpkg' # R

  @make_common_opts = ['SYS=posix', "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}",
                       "mandir=#{CREW_PREFIX}/share/man", 'CRYPTO=GNUTLS']

  def self.build
    system 'make', *@make_common_opts
  end

  def self.install
    system 'make', *@make_common_opts, "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
