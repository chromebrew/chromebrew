require 'package'

class Nocodb < Package
  description 'Open Source Airtable Alternative'
  homepage 'https://nocodb.com/'
  version '0.258.10'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/nocodb/nocodb/releases/download/#{version}/Noco-linux-x64"
  source_sha256 '0065e228e7e141fceffd795fd352790812d6b629746aaf7d55e05f3774db139b'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'Noco-linux-x64', "#{CREW_DEST_PREFIX}/bin/nocodb", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'nocodb' to get started.\n"
  end
end
