require 'package'

class Nocodb < Package
  description 'Open Source Airtable Alternative'
  homepage 'https://nocodb.com/'
  version '0.264.4'
  license 'AGPL-3.0'
  compatibility 'x86_64'
  source_url "https://github.com/nocodb/nocodb/releases/download/#{version}/Noco-linux-x64"
  source_sha256 '77c20e3c9217f1da3e31937848aabc2dda372e6b3c7e1864981739f4ba2f5f68'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'Noco-linux-x64', "#{CREW_DEST_PREFIX}/bin/nocodb", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'nocodb' to get started.\n"
  end
end
