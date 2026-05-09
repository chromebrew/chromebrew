require 'package'

class Dnsmasq < Package
  description 'Lightweight, easy to configure DNS forward ,TFTP server and DHCP server'
  homepage 'https://thekelleys.org.uk/dnsmasq/doc.html'
  version '2.92'
  license 'GPL-2 or GPL-3'
  compatibility 'all'
  source_url "https://thekelleys.org.uk/dnsmasq/dnsmasq-#{version}.tar.xz"
  source_sha256 '4bf50c2c1018f9fbc26037df51b90ecea0cb73d46162846763b92df0d6c3a458'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '909462504985225785fe23c88806120a7f1a544b2ce47ff221e4d2cd3fc28f57',
     armv7l: '909462504985225785fe23c88806120a7f1a544b2ce47ff221e4d2cd3fc28f57',
       i686: 'c76c7b8bad418e3f64b8fca2eab47d64a1ac5b21cf06b948f0ea19a8c0985607',
     x86_64: '9670b1ee33df42da9078e77b568f3edacaf994c9d326b48bea53114a708bb758'
  })

  depends_on 'glibc' => :executable

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
