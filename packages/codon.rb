require 'package'

class Codon < Package
  description 'Codon is a high-performance Python compiler that compiles Python code to native machine code without any runtime overhead.'
  homepage 'https://docs.exaloop.io/codon/'
  version '0.16.3'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/exaloop/codon/releases/download/v0.16.3/codon-linux-x86_64.tar.gz'
  source_sha256 '9b93e83b2aeb0dfb00d673a4482e9e22500469b92233438a2bbf188e0d08aa37'

  depends_on 'llvm'
  depends_on 'python3'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['lib/codon/*.so'], 'lib64'
    %w[bin include lib lib64].each do |dir|
      FileUtils.mv dir, CREW_DEST_PREFIX
    end
  end
end
