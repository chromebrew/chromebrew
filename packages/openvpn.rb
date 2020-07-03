require 'package'

class Openvpn < Package
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.4.9'
  compatibility 'all'
  source_url 'https://swupdate.openvpn.org/community/releases/openvpn-2.4.9.tar.xz'
  source_sha256 '641f3add8694b2ccc39fd4fd92554e4f089ad16a8db6d2b473ec284839a5ebe2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openvpn-2.4.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openvpn-2.4.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openvpn-2.4.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openvpn-2.4.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '27e5efdb11c4d8b9af843d5e6cff5a6792dda5b09498f8781d6e094261869c59',
     armv7l: '27e5efdb11c4d8b9af843d5e6cff5a6792dda5b09498f8781d6e094261869c59',
       i686: '113d563f0881a1de9c742913ea32daca76a5e9da938c102245024b9072d80348',
     x86_64: '02353189cfcc0fbe81ec8e13014d85dc67ce1a0c0c64ce2b6008345696d109c0',
  })

  depends_on 'libmbedtls'
  depends_on 'lzo'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
