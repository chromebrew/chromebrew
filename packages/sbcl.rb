require 'package'

class Sbcl < Package
  description 'Steel Bank Common Lisp (SBCL) is a high performance Common Lisp compiler.'
  homepage 'http://www.sbcl.org/index.html'
  version '2.6.10'
  license 'MIT'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/sbcl/sbcl/#{version}/sbcl-#{version}-source.tar.bz2"
  source_sha256 'c23eac1d0aa9ae0add7eb741f3c91b816f5ce216147f37b99da1578e5261b17c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53d942885d0770b233c4e25721eb15592731dbd5d3c85b138f797f40e29f4fb7',
     armv7l: '53d942885d0770b233c4e25721eb15592731dbd5d3c85b138f797f40e29f4fb7',
       i686: '607ce1861fff0b98807ef4a52c76faaa44cc8e72efeeb83b833da9439eae8137',
     x86_64: 'd417c7de2a6434dc731876f66bcdb011c63087b1858cf1176e433e14e0b0d777'
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
