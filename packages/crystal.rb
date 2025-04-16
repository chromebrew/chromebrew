require 'package'

class Crystal < Package
  description 'A language for humans and computers'
  homepage 'https://crystal-lang.org/'
  version '1.16.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/crystal-lang/crystal/releases/download/1.16.0/crystal-1.16.0-1-linux-x86_64-bundled.tar.gz'
  source_sha256 'cd8ac2ef5f67188bc0a9f83039bd9f49d18b858904f9b0fbf44f46e03414d8fc'

  depends_on 'llvm16_lib' # R

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX} #{CREW_DEST_PREFIX}/etc/bash.d]
    FileUtils.mv %w[bin lib share], CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/bash-completion/completions/crystal", "#{CREW_DEST_PREFIX}/etc/bash.d/10-crystal"
  end
end
