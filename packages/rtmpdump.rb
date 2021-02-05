require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'c5f04a58f-1'
  compatibility 'all'
  source_url 'https://git.ffmpeg.org/gitweb/rtmpdump.git/snapshot/c5f04a58fc2aeea6296ca7c44ee4734c18401aa3.tar.gz'
  source_sha256 'fd8c21263d93fbde8bee8aa6c5f6a657789674bb0f9e74f050651504d5f43b46'
  @make_common_opts = ['SYS=posix', "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}", 'CRYPTO=GNUTLS']

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '47e67bbdb93c72136630dfc35c37ddd7d37c242fbd3446f67ff40b52376fa3e6',
      armv7l: '47e67bbdb93c72136630dfc35c37ddd7d37c242fbd3446f67ff40b52376fa3e6',
        i686: '109fb6fa70409f8ba274fa452c2e04dc1ff3ba740f618525c188139c1ddce363',
      x86_64: '0212408c6faad92b5909d77188d8c27e68ce955f61dcb5597603303e31e601ce',
  })

  def self.build
    system "make", *@make_common_opts
  end

  def self.install
    system 'make', *@make_common_opts, "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
