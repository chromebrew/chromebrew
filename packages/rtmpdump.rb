require 'package'

class Rtmpdump < Package
  description 'rtmpdump is a toolkit for RTMP streams.'
  homepage 'https://rtmpdump.mplayerhq.hu/'
  version 'c5f04a58'
  compatibility 'all'
  source_url 'https://git.ffmpeg.org/gitweb/rtmpdump.git/snapshot/c5f04a58fc2aeea6296ca7c44ee4734c18401aa3.tar.gz'
  source_sha256 'fd8c21263d93fbde8bee8aa6c5f6a657789674bb0f9e74f050651504d5f43b46'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rtmpdump-c5f04a58-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '31c1053a2ba5775de0ea099447af443bdcb8732a7851c581219c7bc9177cafe4',
     armv7l: '31c1053a2ba5775de0ea099447af443bdcb8732a7851c581219c7bc9177cafe4',
       i686: 'f21b4f9f4c3978db0bb4e0814993b7af076e04c6b86d6a3b5fa548f6fa0cf9e6',
     x86_64: '74ec242f369bdf542f725a7675a11be49d8ee898f6f2b963b406b4004d45effe',
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
