require 'package'

class Kilo < Package
  description 'All-in-one agentic engineering platform.'
  homepage 'https://kilo.ai/'
  version '7.8.17'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/Kilo-Org/kilocode/releases/download/v#{version}/kilo-linux-x64.tar.gz"
  source_sha256 '73491b15e9816fa1c982331ff4d8418e5aa9fd6d861853ab4c81935200ae8f6a'

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
