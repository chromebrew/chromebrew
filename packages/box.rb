require 'package'

class Box < Package
  description 'Fast, zero config application bundler with PHARs.'
  homepage 'https://github.com/box-project/box'
  version '4.6.1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/box-project/box/releases/download/4.6.1/box.phar'
  source_sha256 '8d12a7d69a5003a80bd603ea95a8f3dcea30b9a2ad84cd7cb15b8193929def9e'

  depends_on 'php82' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.preflight
    major = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f1`
    minor = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f2`
    abort "acli requires php >= 8.2. php#{major.chomp}#{minor.chomp} does not meet the minimum requirement.".lightred unless major.empty? || minor.empty? || ((major.to_i >= 8) && (minor.to_i >= 2))
  end

  def self.install
    FileUtils.install 'box.phar', "#{CREW_DEST_PREFIX}/bin/box", mode: 0o755
  end
end
