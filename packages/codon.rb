require 'package'

class Codon < Package
  description 'Codon is a high-performance Python compiler that compiles Python code to native machine code without any runtime overhead.'
  homepage 'https://docs.exaloop.io/codon/'
  version '0.18.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/exaloop/codon/releases/download/v#{version}/codon-linux-x86_64.tar.gz"
  source_sha256 'bef8ffdfc3fb36b079f298881611315e1cfa953b81bb05d7ceb85d43840102c1'

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
