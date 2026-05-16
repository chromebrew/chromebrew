require 'package'

class Crystal < Package
  description 'A language for humans and computers'
  homepage 'https://crystal-lang.org/'
  version '1.20.2'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/crystal-lang/crystal/releases/download/#{version}/crystal-#{version}-1-linux-x86_64-bundled.tar.gz"
  source_sha256 '733c35d39b961687fd4d799b37e52d191a8777213469d47803c019dfa52fa685'

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_LIB_PREFIX} #{CREW_DEST_PREFIX}/etc/bash.d]
    FileUtils.mv %w[bin share], CREW_DEST_PREFIX
    FileUtils.mv Dir['lib/*'], CREW_DEST_LIB_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/bash-completion/completions/crystal", "#{CREW_DEST_PREFIX}/etc/bash.d/10-crystal"
  end
end
