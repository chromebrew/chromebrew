require 'package'

class Libnftnl < Package
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.2.5'
  compatibility 'all'
  source_url 'https://netfilter.org/projects/libnftnl/files/libnftnl-1.2.5.tar.xz'
  source_sha256 '966de0a8120c8a53db859889749368bfb2cba0c4f0b4c1a30d264eccc45f1226'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.5_armv7l/libnftnl-1.2.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.5_armv7l/libnftnl-1.2.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.5_i686/libnftnl-1.2.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnftnl/1.2.5_x86_64/libnftnl-1.2.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2466837daabd1954e66a0032ee1fe14feac173bb03d5e4b1ba0e1e001169832c',
     armv7l: '2466837daabd1954e66a0032ee1fe14feac173bb03d5e4b1ba0e1e001169832c',
       i686: '19843a030252288ea8e7c44e29915d4ac2d01d55858a41120712162e5972e14a',
     x86_64: '00d251006611eb159fc38fb38c572e7a4aba843042e40b8d8f414b000f18040b'
  })

  depends_on 'libmnl' # R
  depends_on 'glibc' # R

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
