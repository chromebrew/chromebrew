require 'buildsystems/autotools'

class Moreutils < Autotools
  description 'Growing collection of the unix tools that nobody thought to write long ago when unix was young.'
  homepage 'https://joeyh.name/code/moreutils/'
  version '0.70'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://http.debian.net/debian/pool/main/m/moreutils/moreutils_#{version}.orig.tar.xz"
  source_sha256 'a844c5e3360a73d12c0a5624750ecc1969d64afea2e84925328f137576e2eb55'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9849c38dc05d08c82fc4898e268d47909451b1d6455ff83cb50e8e75099aa789',
     armv7l: '9849c38dc05d08c82fc4898e268d47909451b1d6455ff83cb50e8e75099aa789',
       i686: '0875f08ef243ff2dd953fa4c9883b8f743d8122800ef5e9dac6d5b324a1e4986',
     x86_64: '919c1c1aee64008e5f97a8c413b8618f4f64d7958d634dd62403ee1e2a158718'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libxslt' => :build
  depends_on 'perl_ipc_run' => :executable

  autotools_skip_configure

  def self.patch
    system "sed -i 's,PREFIX?=/usr,PREFIX?=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,DOCBOOKXSL?=/usr/share/xml/docbook/stylesheet/docbook-xsl,DOCBOOKXSL?=#{CREW_PREFIX}/share/xml/docbook/stylesheet/docbook-xsl,' Makefile"
    system "sed -i 's,share/man,man,g' Makefile"
  end

  autotools_install_extras do
    Dir["#{CREW_DEST_PREFIX}/bin/*"].each do |bin|
      system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' #{bin}"
    end
  end
end
