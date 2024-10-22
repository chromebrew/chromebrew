require 'package'

class Txt2regex < Package
  description 'Regex wizard for the terminal, written in Bash'
  homepage 'https://aurelio.net/projects/txt2regex/'
  version '0.9'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/aureliojargas/txt2regex/archive/v0.9.tar.gz'
  source_sha256 '3bbccde25f942129450f34d6d4975f4234958072540e758bc131bb7960716d63'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'txt2regex.sh', "#{CREW_DEST_PREFIX}/bin/txt2regex", mode: 0o755
  end
end
