require 'package'

class Box < Package
  description 'Fast, zero config application bundler with PHARs.'
  homepage 'https://github.com/box-project/box'
  version '4.6.2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/box-project/box/releases/download/4.6.2/box.phar'
  source_sha256 '3bfb1c1f37a74a78d1178bb92c508de4bf202aae0fb3f33f69ec3577c452de18'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

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
