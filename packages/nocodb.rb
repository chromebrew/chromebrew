require 'package'

class Nocodb < Package
  description 'Open Source Airtable Alternative'
  homepage 'https://nocodb.com/'
  version '0.264.4'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/nocodb/nocodb/releases/download/#{version}/Noco-linux-x64"
  source_sha256 'd8224675bf8b07428579b9f2b5e270b34279003921604985040d98a8bf9ae356'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'Noco-linux-x64', "#{CREW_DEST_PREFIX}/bin/nocodb", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'nocodb' to get started.\n"
  end
end
