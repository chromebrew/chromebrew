require 'package'

class Box < Package
  description 'Fast, zero config application bundler with PHARs.'
  homepage 'https://github.com/box-project/box'
  version '3.16.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    downloader 'https://github.com/box-project/box/releases/download/3.16.0/box.phar'
    unless Digest::SHA256.hexdigest( File.read('box.phar') ) == 'f508e28f309d7e95a319bdcd5f13dcfbb18eb91cb7a6cac9b69bc7799d78bdf9'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'box.phar', "#{CREW_DEST_PREFIX}/bin/box", mode: 0o755
  end
end
