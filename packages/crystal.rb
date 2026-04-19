require 'package'

class Crystal < Package
  description 'A language for humans and computers'
  homepage 'https://crystal-lang.org/'
  version '1.20.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/crystal-lang/crystal/releases/download/#{version}/crystal-#{version}-1-linux-x86_64-bundled.tar.gz"
  source_sha256 '9f6fb0dd6b38daa22b6fba07342ff72390efe533639d181360793a218ca164c9'

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_LIB_PREFIX} #{CREW_DEST_PREFIX}/etc/bash.d]
    FileUtils.mv %w[bin share], CREW_DEST_PREFIX
    FileUtils.mv Dir['lib/*'], CREW_DEST_LIB_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/bash-completion/completions/crystal", "#{CREW_DEST_PREFIX}/etc/bash.d/10-crystal"
  end
end
