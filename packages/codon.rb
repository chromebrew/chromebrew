require 'package'

class Codon < Package
  description 'Codon is a high-performance Python compiler that compiles Python code to native machine code without any runtime overhead.'
  homepage 'https://docs.exaloop.io/codon/'
  version '0.19.3'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/exaloop/codon/releases/download/v#{version}/codon-linux-x86_64.tar.gz"
  source_sha256 'f27abda792c0c9f9a42d529c2e0a1b2113ec6964eec23d6f62acef9ed42c3de6'

  depends_on 'llvm'
  depends_on 'python3'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.rm_rf Dir['include/llvm*']
    FileUtils.mv Dir['lib/codon/*.so'], 'lib64'
    %w[bin include lib lib64].each do |dir|
      FileUtils.mv dir, CREW_DEST_PREFIX
    end
  end
end
