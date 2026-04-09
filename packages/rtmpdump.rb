require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version '2.6'
  license 'LGPL-2.1 and GPL-2'
  compatibility 'all'
  source_url 'https://git.ffmpeg.org/rtmpdump.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3caa5604d209754907f3f2bec41f9c0e6f04b97c78185d6ffd0734570d34138a',
     armv7l: '3caa5604d209754907f3f2bec41f9c0e6f04b97c78185d6ffd0734570d34138a',
       i686: 'a2db119add3cf81d6654dade8883fde63166004b5cc8b2365d667391eaf7b688',
     x86_64: '76e290362911b80a600e654556f3cfe95357b1fd99e5daad9af06ce204bdb88d'
  })

  depends_on 'glibc' => :library
  depends_on 'gmp' => :library
  depends_on 'openssl' => :library
  depends_on 'zlib' => :library

  @make_common_opts = ['SYS=posix', "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}",
                       "mandir=#{CREW_PREFIX}/share/man", 'CRYPTO=OPENSSL']

  def self.build
    system 'make', *@make_common_opts
  end

  def self.install
    system 'make', *@make_common_opts, "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
