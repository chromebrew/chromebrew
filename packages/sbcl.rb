require 'package'

class Sbcl < Package
  description 'Steel Bank Common Lisp (SBCL) is a high performance Common Lisp compiler.'
  homepage 'http://www.sbcl.org/index.html'
  version '2.6.8'
  license 'MIT'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/sbcl/sbcl/#{version}/sbcl-#{version}-source.tar.bz2"
  source_sha256 'ad5126dfdfba5db27ee77bcc25893020fe522d0b7653d45b4c4795ade3ddc23d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '317afcde34411d5edd048d274599b3a29243ade94da1fc9cf1a39114fb3a993a',
     armv7l: '317afcde34411d5edd048d274599b3a29243ade94da1fc9cf1a39114fb3a993a',
       i686: '3fb77e07777b726b06078d993b3ed3f86dfd65a7013f28caa36fd7b03dcc104f',
     x86_64: '5cdc3c6fe964426a94747521658907a4031945e8e2896cc0e8c0f391108f3d9e'
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
