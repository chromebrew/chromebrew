require 'package'

class Nocodb < Package
  description 'Open Source Airtable Alternative'
  homepage 'https://nocodb.com/'
  version '0.260.5'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/nocodb/nocodb/releases/download/#{version}/Noco-linux-x64"
  source_sha256 '57121bb3b87c9e216332d63c5fe59ab9e94b1d49e1b0373556a2b9fd1a3ad28f'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'Noco-linux-x64', "#{CREW_DEST_PREFIX}/bin/nocodb", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'nocodb' to get started.\n"
  end
end
