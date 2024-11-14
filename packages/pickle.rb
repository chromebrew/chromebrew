require 'package'

class Pickle < Package
  description 'PHP Extension installer'
  homepage 'https://github.com/friendsofphp/pickle'
  version '0.7.11'
  license 'BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/FriendsOfPHP/pickle/releases/download/v0.7.11/pickle.phar'
  source_sha256 'fe68430bbaf01b45c7bf46fa3fd2ab51f8d3ab41e6f5620644d245a29d56cfd6'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install 'pickle.phar', "#{CREW_DEST_PREFIX}/bin/pickle", mode: 0o755
  end
end
