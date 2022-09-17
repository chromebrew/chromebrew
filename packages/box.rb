require 'package'

class Box < Package
  description 'Fast, zero config application bundler with PHARs.'
  homepage 'https://github.com/box-project/box'
  version '4.0.2'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/box-project/box/releases/download/#{version}/box.phar"
  source_sha256 'ddb2ddb694ba07e5fcd0dc681e204f7a94844409a26f7b74bb1fe2748908fd9e'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'box.phar', "#{CREW_DEST_PREFIX}/bin/box", mode: 0o755
  end
end
