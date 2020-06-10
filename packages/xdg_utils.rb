require 'package'

class Xdg_utils < Package
  description 'xdg-utils is a set of tools that allows applications to easily integrate with the desktop environment of the user, regardless of the specific desktop environment that the user runs.'
  homepage 'https://www.freedesktop.org/wiki/Software/xdg-utils/'
  version '1.1.3-1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/v1.1.3/xdg-utils-v1.1.3.tar.bz2'
  source_sha256 'deac55c48aa2902023c96a4bea2f1778441ce9c59e60ed52c6ce5d8b3e90ba64'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_utils-1.1.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_utils-1.1.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_utils-1.1.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xdg_utils-1.1.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5d39a96a61b59eed8219727da0a6197c7b7f941b40a75eece77c9a0215e8559e',
     armv7l: '5d39a96a61b59eed8219727da0a6197c7b7f941b40a75eece77c9a0215e8559e',
       i686: 'dc89bcf110e5d20900dea98271739fe2a43b914ae2ba93cc16782265b0323ab0',
     x86_64: 'b76c87093c24193d0010ad125573cc48259339eae4709f0733f825b45bba79de',
  })

  depends_on 'elinks' => :build
  depends_on 'libxslt' => :build
  depends_on 'xmlto' => :build

  def self.patch
    system "find -name '*.xml' -exec sed -i 's,http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd,file://#{CREW_PREFIX}/share/xml/docbook/xml-dtd-4.3/docbookx.dtd,' {} \\;"
  end

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "sed -i 's,\$(XMLTO) man,#{CREW_PREFIX}/bin/xmlto -x #{CREW_PREFIX}/docbook/manpages/docbook.xsl man,' scripts/Makefile"
    system "sed -i 's,\$(XMLTO) html,#{CREW_PREFIX}/bin/xmlto -x #{CREW_PREFIX}/docbook/html/docbook.xsl html,' scripts/Makefile"
    system "sed -i 's,\$(XMLTO) txt,#{CREW_PREFIX}/bin/xmlto -x #{CREW_PREFIX}/docbook/html/docbook.xsl txt,' scripts/Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
