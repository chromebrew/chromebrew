require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'f1b83'
  license 'LGPL-2.1 and GPL-2'
  compatibility 'all'
  source_url 'https://git.ffmpeg.org/rtmpdump.git'
  git_hashtag 'f1b83c10d8beb43fcc70a6e88cf4325499f25857'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '93a414b097aaf7e2a2c412fb412d6403563427e5a008b98bf2d26d7bbdfb5f3a',
     armv7l: '93a414b097aaf7e2a2c412fb412d6403563427e5a008b98bf2d26d7bbdfb5f3a',
       i686: '843c971613a11a672741cbe0094e869e049c4986234d99836abaa99bf0de1386',
     x86_64: '7e76a4f0a4f359f5ab8283ac175c4dc85f2d54aad1413840240627e810d5c6c0'
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
