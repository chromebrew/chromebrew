require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.0.4-1'
  source_url 'http://mirror.keystealth.org/gnu/bison/bison-3.0.4.tar.xz'
  source_sha1 '8270497aad88c7dd4f2c317298c50513fb0c3c8e'

  depends_on 'diffutils' => :build
  depends_on 'm4' => :build
  depends_on 'perl' => :build
  # `make check` requires flex, but it causes dependency loop.  so, commenting it out.
  # depends_on 'flex' => :build

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
    system "find . -name '*.a' -print | xargs strip -S"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make check"
  end
end
