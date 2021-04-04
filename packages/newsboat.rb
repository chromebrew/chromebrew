require 'package'

class Newsboat < Package
  description 'Newsboat is an RSS/Atom feed reader for the text console.'
  homepage 'https://newsboat.org/'
  version '2.23'
  license 'MIT'
  compatibility 'all'
  source_url 'https://newsboat.org/releases/2.23/newsboat-2.23.tar.xz'
  source_sha256 'b997b139d41db2cc5f54346f27c448bee47d6c6228a12ce9cb91c3ffaec7dadc'
  
  depends_on 'sqlite'
  depends_on 'gettext'
  depends_on 'libxml2'
  depends_on 'libstfl'
  depends_on 'jsonc'
  depends_on 'openssl'
  depends_on 'asciidoctor' => :build
  depends_on 'rust' => :build
  
  def self.patch
    system "sed -i 's:prefix?=/usr/local:prefix?=#{CREW_PREFIX}:' Makefile"
  end
  
  def self.build
    system "make"
  end
  
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
