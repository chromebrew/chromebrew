require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'c5f04a58f'
  compatibility 'all'
  source_url 'https://git.ffmpeg.org/gitweb/rtmpdump.git/snapshot/c5f04a58fc2aeea6296ca7c44ee4734c18401aa3.tar.gz'
  source_sha256 'fd8c21263d93fbde8bee8aa6c5f6a657789674bb0f9e74f050651504d5f43b46'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58f-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9e8f50f34f570d8bd6fb161fd96dc4c3384259e07eeebf03cc975b4eb9d21306',
     armv7l: '9e8f50f34f570d8bd6fb161fd96dc4c3384259e07eeebf03cc975b4eb9d21306',
       i686: '3f28349cce85d7cc73208f7bd921543baea29dd1994e068ecf3597119b761a18',
     x86_64: '015f35c6556f9fa4100093e0cb44581ad0725a25391b301ce8972e5a090c8cec',
  })

  def self.build
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,prefix=/usr/local,prefix=#{CREW_PREFIX},' librtmp/Makefile"
    system "sed -i 's,libdir=\$(prefix)/lib,libdir=#{CREW_LIB_PREFIX},' librtmp/Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
