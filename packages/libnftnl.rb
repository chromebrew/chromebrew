require 'package'

class Libnftnl < Package
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  compatibility 'all'
  version '1.1.7-1'
  source_url 'https://netfilter.org/projects/libnftnl/files/libnftnl-1.1.7.tar.bz2'
  source_sha256 '20dbc13f11004aea2c9e479cfb90359cb11fe3446c3140811c18e4ec1648ed8f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnftnl-1.1.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnftnl-1.1.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnftnl-1.1.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnftnl-1.1.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6cc802f2d8a84367d34fc91c32aa8f06715a0cac91d4c6ea774fe2905be1255a',
     armv7l: '6cc802f2d8a84367d34fc91c32aa8f06715a0cac91d4c6ea774fe2905be1255a',
       i686: '510a3ca438c83f53457707bc89e6ddab8332fb7e5343721def87cbc9a86c34da',
     x86_64: '7e72516f66aab3d3ed6d554e72c0b198ec82ee8e061a7c3941d607890de100f2',
  })

  depends_on 'libmnl'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
