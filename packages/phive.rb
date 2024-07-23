require 'package'

class Phive < Package
  description 'The PHAR Installation and Verification Environment (PHIVE)'
  homepage 'https://phar.io/'
  version '0.15.2'
  license 'BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/phar-io/phive/releases/download/#{version}/phive-#{version}.phar"
  source_sha256 '2bb076753ec5d672f5e2f96a97a0fe7e8e9ec24a439eed00fd29ef942c7905f9'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install "phive-#{version}.phar", "#{CREW_DEST_PREFIX}/bin/phive", mode: 0o755
  end
end
