require 'buildsystems/autotools'

class Iptables < Autotools
  description 'iptables is the userspace command line program used to configure the Linux 2.4.x and later packet filtering ruleset.'
  homepage 'https://www.netfilter.org/projects/iptables/'
  version '1.8.11'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.netfilter.org/projects/iptables/files/iptables-#{version}.tar.xz"
  source_sha256 'd87303d55ef8c92bcad4dd3f978b26d272013642b029425775f5bad1009fe7b2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cceb641d27a6c9cbf4dd24860dc9317371a99b97dd3c964455c69202f9a5ea70',
     armv7l: 'cceb641d27a6c9cbf4dd24860dc9317371a99b97dd3c964455c69202f9a5ea70',
     x86_64: '0d22c11c74dd468b51b11b72a3daf4f18b44e123ef5cd5a15bb901aa26ae7b52'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--enable-static --disable-nftables'
end
