require 'package'

class Phive < Package
  description 'The PHAR Installation and Verification Environment (PHIVE)'
  homepage 'https://phar.io/'
  version '0.15.3'
  license 'BSD'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/phar-io/phive/releases/download/#{version}/phive-#{version}.phar"
  source_sha256 '3f4ab8130e83bb62c2a51359e7004df95b60ad07bbd319f4b39d35a48a051e27'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.install "phive-#{version}.phar", "#{CREW_DEST_PREFIX}/bin/phive", mode: 0o755
  end
end
