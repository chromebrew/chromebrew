require 'package'

class Crystal < Package
  description 'A language for humans and computers'
  homepage 'https://crystal-lang.org/'
  version '1.17.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/crystal-lang/crystal/releases/download/#{version}/crystal-#{version}-1-linux-x86_64-bundled.tar.gz"
  source_sha256 'cb24d17927a8dc712aaa2ed1c78cedf4ebf96afc5a1de72b569896e8d8cbc991'

  no_compile_needed
  print_source_bashrc

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX} #{CREW_DEST_PREFIX}/etc/bash.d]
    FileUtils.mv %w[bin lib share], CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/bash-completion/completions/crystal", "#{CREW_DEST_PREFIX}/etc/bash.d/10-crystal"
  end
end
