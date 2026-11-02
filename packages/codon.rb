require 'package'

class Codon < Package
  description 'Codon is a high-performance Python compiler that compiles Python code to native machine code without any runtime overhead.'
  homepage 'https://docs.exaloop.io/codon/'
  version '0.20.6'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/exaloop/codon/releases/download/v#{version}/codon-linux-x86_64.tar.gz"
  source_sha256 '688772b279465e6d6ad7269741844f17dc5834eef4333f8a7851b6446f7143b6'

  depends_on 'llvm'
  depends_on 'python3'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.rm_rf Dir['include/llvm*']
    FileUtils.mv Dir['lib/codon/*.so'], 'lib64/'
    FileUtils.mv Dir['lib/*'], 'lib64/'
    %w[bin include lib64].each do |dir|
      FileUtils.mv dir, CREW_DEST_PREFIX
    end
  end
end
