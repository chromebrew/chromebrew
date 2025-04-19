require 'package'

class Crystal < Package
  description 'A language for humans and computers'
  homepage 'https://crystal-lang.org/'
  version '1.16.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/crystal-lang/crystal/releases/download/1.16.1/crystal-1.16.1-1-linux-x86_64-bundled.tar.gz'
  source_sha256 '1e53c11e831eea3637434ad0f4beef30e5ae78e823f5d23945f213c55ab22ac6'

  depends_on 'llvm16_lib' # R

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX} #{CREW_DEST_PREFIX}/etc/bash.d]
    FileUtils.mv %w[bin lib share], CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/bash-completion/completions/crystal", "#{CREW_DEST_PREFIX}/etc/bash.d/10-crystal"
  end
end
