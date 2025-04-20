require 'package'

class Phive < Package
  description 'The PHAR Installation and Verification Environment (PHIVE)'
  homepage 'https://phar.io/'
  version '0.16.0'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/phar-io/phive/releases/download/#{version}/phive-#{version}.phar"
  source_sha256 '1525f25afec4bcdc0aa8db7bb4b0063851332e916698daf90c747461642a42ed'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install "phive-#{version}.phar", "#{CREW_DEST_PREFIX}/bin/phive", mode: 0o755
  end
end
