require 'package'

class Sbcl < Package
  description 'Steel Bank Common Lisp (SBCL) is a high performance Common Lisp compiler.'
  homepage 'http://www.sbcl.org/index.html'
  version '2.6.9'
  license 'MIT'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/sbcl/sbcl/#{version}/sbcl-#{version}-source.tar.bz2"
  source_sha256 'c6fd1d735570eb4ff34caf9609988ca77ed0bd12b55d09a4fed075be890da513'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44863cc2769b8a5cd8e78b0336f4b356b2e26a1bd2b5302ee4123e0da153e46f',
     armv7l: '44863cc2769b8a5cd8e78b0336f4b356b2e26a1bd2b5302ee4123e0da153e46f',
       i686: '8f6266debda254d25a5bae59b8039cc8433fe6253ede06e4fb40864b1c45960f',
     x86_64: 'c0b48d53c62a4fb49b93e52a39a25f570e7bd0c66d2420af31b762face5724f9'
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
