require 'package'

class Sbcl < Package
  description 'Steel Bank Common Lisp (SBCL) is a high performance Common Lisp compiler.'
  homepage 'http://www.sbcl.org/index.html'
  version '2.6.7'
  license 'MIT'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/sbcl/sbcl/#{version}/sbcl-#{version}-source.tar.bz2"
  source_sha256 '1ebdc35c9dc8e271b8cd1ac44965e00bf255f9c0221650fcb77f0fb34c2d3ade'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd4f5e8d4b2ef6877b4dc1664133add988315d991e1779cd5d0574e374e9f3c8',
     armv7l: 'cd4f5e8d4b2ef6877b4dc1664133add988315d991e1779cd5d0574e374e9f3c8',
       i686: 'e23255ea1e214b10cefa5ef05df2cb062e5009a7c409165bdc1595d6f4d9009a',
     x86_64: 'e1d53463b3a5cdb04552976129ad7924a356eea154123da8d443a961c080847d'
  })

  depends_on 'clisp' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system "sh ./make.sh --prefix=#{CREW_PREFIX} --xc-host='clisp'"
  end

  def self.install
    system "INSTALL_ROOT=#{CREW_DEST_PREFIX} sh install.sh"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sbcl"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin", "#{CREW_DEST_PREFIX}/share/sbcl"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", "#{CREW_DEST_PREFIX}/share/sbcl"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/sbcl/bin/sbcl", "#{CREW_DEST_PREFIX}/bin/sbcl"
  end
end
