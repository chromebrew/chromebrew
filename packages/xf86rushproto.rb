require 'package'

class Xf86rushproto < Package
  description 'X.org XF86Rush protocol headers'
  homepage 'http://www.x.org'
  version '1.1.2'
  source_url 'https://www.x.org/archive/individual/proto/xf86rushproto-1.1.2.tar.gz'
  source_sha256 '7d420ae7e5f0dd94c6010c764c66acc93eed7df7f81bcf93d2a57739970ec841'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86rushproto-1.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xf86rushproto-1.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xf86rushproto-1.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xf86rushproto-1.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '297e0eee886495fddd18e3532aaf8271533837d371cb3a1985fbb4af71e572c6',
     armv7l: '297e0eee886495fddd18e3532aaf8271533837d371cb3a1985fbb4af71e572c6',
       i686: 'fa7de08e4303d175884684ae0d8de531f1ef16eabae1f1f2944f07a881b4d83a',
     x86_64: 'fcf739061c226a180426bbb115f03bdb550d0c3cdfc3cab6508f14694bd23280',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
