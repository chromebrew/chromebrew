require 'package'

class Txt2regex < Package
  description 'Regex wizard for the terminal, written in Bash'
  homepage 'http://aurelio.net/projects/txt2regex/'
  version '0.8'
  compatibility 'all'
  source_url 'https://github.com/aureliojargas/txt2regex/archive/v0.8.tar.gz'
  source_sha256 '31a83516db6c88c07a3d5440136d4fe3928090f0d8b59cb127ca611d6bb9dda9'

  def self.install
    system "install -Dm755 txt2regex.sh #{CREW_DEST_PREFIX}/bin/txt2regex"
  end
end
