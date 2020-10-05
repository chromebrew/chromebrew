require 'package'

class Libnftnl < Package
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  compatibility 'all'
  version '1.1.7-1'
  source_url 'https://netfilter.org/projects/libnftnl/files/libnftnl-1.1.7.tar.bz2'
  source_sha256 '20dbc13f11004aea2c9e479cfb90359cb11fe3446c3140811c18e4ec1648ed8f'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
