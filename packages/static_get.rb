require 'package'

class Static_get < Package
  description 'Portable binaries for Linux'
  homepage 'http://s.minos.io/'
  version '61cdcec'
  license 'Unknown'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/minos-org/minos-static/61cdcec177d400182b7f36062e808cee21999777/static-get'
  source_sha256 '135194e727f8b73cf460714a893bee8651a1e8d7a1d6142450c7b5168bc03549'

  no_compile_needed

  def self.install
    FileUtils.install 'static-get', "#{CREW_DEST_PREFIX}/bin/static-get", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'static-get -h' to get started.\n"
  end
end
