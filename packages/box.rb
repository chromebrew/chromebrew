require 'package'

class Box < Package
  description 'Fast, zero config application bundler with PHARs.'
  homepage 'https://github.com/box-project/box'
  version '4.3.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/box-project/box/releases/download/4.3.8/box.phar'
  source_sha256 '83d63ddb24ecc97538356b90c320773d1aca2712d14813bd27bee3ba65cf3b18'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'box.phar', "#{CREW_DEST_PREFIX}/bin/box", mode: 0o755
  end
end
