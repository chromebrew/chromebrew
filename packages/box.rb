require 'package'

class Box < Package
  description 'Fast, zero config application bundler with PHARs.'
  homepage 'https://github.com/box-project/box'
  version '4.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/box-project/box/releases/download/4.2.0/box.phar'
  source_sha256 'f693e1a85abdb7730a23fcbaffb882601f1d75616b69f195715fe4f84c5bf8a4'

  depends_on 'php81' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'box.phar', "#{CREW_DEST_PREFIX}/bin/box", mode: 0o755
  end
end
