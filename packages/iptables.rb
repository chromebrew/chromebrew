require 'buildsystems/autotools'

class Iptables < Autotools
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.8.13'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.netfilter.org/projects/iptables/files/iptables-#{version}.tar.xz"
  source_sha256 '1afcd33da9e8f913ace6a2126788162e207e26f5d5e29c6573c0e581ffc58b99'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a13564bcc3222f90c455e0d4d02683709d56d676fa35f619ddd3b70bb309b15e',
     armv7l: 'a13564bcc3222f90c455e0d4d02683709d56d676fa35f619ddd3b70bb309b15e',
     x86_64: 'e0ac1522ead574b130446aff8abfcdc248ed70144b3e3e3dbbef00c9735396f3'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options '--enable-static --disable-nftables'
end
