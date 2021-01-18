require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.7.4'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/bison/bison-3.7.4.tar.xz'
  source_sha256 'a3b5813f48a11e540ef26f46e4d288c0c25c7907d9879ae50e430ec49f63c010'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make check'
  end
end
