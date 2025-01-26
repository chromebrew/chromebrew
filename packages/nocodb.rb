require 'package'

class Nocodb < Package
  description 'Open Source Airtable Alternative'
  homepage 'https://nocodb.com/'
  version '0.260.2'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/nocodb/nocodb/releases/download/#{version}/Noco-linux-x64"
  source_sha256 'ff6b209017e27ca8bc9f7a19308c1dfcb9a4471cf4e571fa2a4e65259be23974'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'Noco-linux-x64', "#{CREW_DEST_PREFIX}/bin/nocodb", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'nocodb' to get started.\n"
  end
end
