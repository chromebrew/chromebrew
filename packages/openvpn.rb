require 'package'

class Openvpn < Package
  description 'OpenVPN is an open source VPN daemon'
  homepage 'https://openvpn.net/'
  version '2.6.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/OpenVPN/openvpn/archive/v2.6.4.tar.gz'
  source_sha256 'bfab07b900262a990fc4519596b29c380ed5a89216593f04719279715ebd04d3'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openvpn/2.6.4_armv7l/openvpn-2.6.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openvpn/2.6.4_armv7l/openvpn-2.6.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openvpn/2.6.4_i686/openvpn-2.6.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/openvpn/2.6.4_x86_64/openvpn-2.6.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '31a9562463fc50c4ee38bb4b1b1a1d5335b45e86fe63ffcc6a00162d77a2c165',
     armv7l: '31a9562463fc50c4ee38bb4b1b1a1d5335b45e86fe63ffcc6a00162d77a2c165',
       i686: 'e05794f5f033bb45130025e484d5c45bce4f898e8680d241a129cfd3c4779e9f',
     x86_64: '09020c9a49a82669e1f67a00bc4e3664dd003c16bfde4ce246f89c1127bed7da'
  })

  depends_on 'libmbedtls'
  depends_on 'libnl3'
  depends_on 'lzo'
  depends_on 'mold' => :build
  depends_on 'py3_docutils' => :build

  def self.build
    system 'autoreconf -fiv'
    system "mold -run ./configure #{CREW_OPTIONS}"
    system 'mold -run make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
