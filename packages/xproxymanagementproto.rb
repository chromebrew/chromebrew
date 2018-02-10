require 'package'

class Xproxymanagementproto < Package
  description 'X.org X Proxy Management extension headers'
  homepage 'http://www.x.org'
  version '1.0.3'
  source_url 'https://www.x.org/archive/individual/proto/xproxymanagementprotocol-1.0.3.tar.gz'
  source_sha256 'c1501045ec781f36b6f867611ab2b4e81be542f5c669b2fd0cc4ec1340c42bcf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xproxymanagementproto-1.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xproxymanagementproto-1.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xproxymanagementproto-1.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xproxymanagementproto-1.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c471d3e207749bfd6fa858a95a13b285fdcb1caa1efdc61a2395697f7a088e24',
     armv7l: 'c471d3e207749bfd6fa858a95a13b285fdcb1caa1efdc61a2395697f7a088e24',
       i686: '90399b6d825767ac8cca981c35e2f79ff6ffa2ff5e7815bcb0ca897d71920018',
     x86_64: '1c6d0fe7901a7ba7dfaf15787db49777375b0cd964ed35eeb6af680c5d91ea7c',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
