require 'package'

class Moreutils < Package
  description 'Growing collection of the unix tools that nobody thought to write long ago when unix was young.'
  homepage 'https://joeyh.name/code/moreutils/'
  version '0.69'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://http.debian.net/debian/pool/main/m/moreutils/moreutils_#{version}.orig.tar.xz"
  source_sha256 '2170c46219ce8d6f17702321534769dfbfece52148a78cd12ea73b5d3a72ff7c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c83203b78454cb54457723aa593e062b3bae81eb53ac29e5cf5eccb987b0fccf',
     armv7l: 'c83203b78454cb54457723aa593e062b3bae81eb53ac29e5cf5eccb987b0fccf',
       i686: 'f160028bbb5067a324e03d348c239c739b4bc890b8f721d767a51365ad537ad5',
     x86_64: 'c0347330127aed4625b1108ca4144a5569dee1add6932c63d804589b9be177cc'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'libxslt' => :build

  def self.patch
    system "sed -i 's,PREFIX?=/usr,PREFIX?=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,DOCBOOKXSL?=/usr/share/xml/docbook/stylesheet/docbook-xsl,DOCBOOKXSL?=#{CREW_PREFIX}/share/xml/docbook/stylesheet/docbook-xsl,' Makefile"
    system "sed -i 's,share/man,man,g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
