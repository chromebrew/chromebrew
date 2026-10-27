require 'package'

class Kilo < Package
  description 'All-in-one agentic engineering platform.'
  homepage 'https://kilo.ai/'
  version '7.8.18'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/Kilo-Org/kilocode/releases/download/v#{version}/kilo-linux-x64.tar.gz"
  source_sha256 '503561fb8c4b8ede26703457a912b98cf18c9c9e8961649f3718cf7676b5c02a'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'kilo', "#{CREW_DEST_PREFIX}/share/kilo/kilo", mode: 0o755
    FileUtils.mv 'tree-sitter', "#{CREW_DEST_PREFIX}/share/kilo"
    FileUtils.ln_s "#{CREW_PREFIX}/share/kilo/kilo", "#{CREW_DEST_PREFIX}/bin/kilo"
  end

  def self.postinstall
    ExitMessage.add "\nType 'kilo' to get started.\n"
  end
end
