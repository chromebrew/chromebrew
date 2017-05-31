require 'package'

class Bison < Package
  description 'Bison is a general-purpose parser generator that converts an annotated context-free grammar into a deterministic LR or generalized LR (GLR) parser employing LALR(1) parser tables.'
  homepage 'http://www.gnu.org/software/bison/'
  version '3.0.4'
  source_url 'http://mirror.keystealth.org/gnu/bison/bison-3.0.4.tar.gz'
  source_sha1 'ec1f2706a7cfedda06d29dc394b03e092a1e1b74'

  depends_on 'diffutils'
  depends_on 'm4'

  def self.build
    system './configure --prefix=/usr/local'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
