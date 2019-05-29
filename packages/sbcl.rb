require 'package'

class Sbcl < Package
  description 'Steel Bank Common Lisp (SBCL) is a high performance Common Lisp compiler.'
  homepage 'http://www.sbcl.org/index.html'
  version '1.5.3'
  source_url 'http://prdownloads.sourceforge.net/sbcl/sbcl-1.5.3-source.tar.bz2'
  source_sha256 'd2a7901144d227a7194661dc3ccee28873c8d5cbbd167013660c78b9ad63640c'

  depends_on 'clisp' => :build

  def self.build
    system './make.sh', "--prefix=#{CREW_PREFIX}", '--xc-host=clisp --silent'
  end

  def self.install
    system "INSTALL_ROOT=#{CREW_DEST_PREFIX} sh install.sh"
  end
end
