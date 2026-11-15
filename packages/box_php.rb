require 'package'

class Box_php < Package
  description 'Fast, zero config application bundler with PHARs.'
  homepage 'https://github.com/box-project/box'
  version '4.7.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/box-project/box/releases/download/#{version}/box.phar"
  source_sha256 'aedabb38bad96a90868603f118956c3faa662b545c06be66df1b145aba703c0a'

  depends_on 'php84' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.preflight
    major = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f1`
    minor = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f2`
    abort "box_php requires php >= 8.2. php#{major.chomp}#{minor.chomp} does not meet the minimum requirement.".lightred unless major.empty? || minor.empty? || ((major.to_i >= 8) && (minor.to_i >= 2))
  end

  def self.install
    FileUtils.install 'box.phar', "#{CREW_DEST_PREFIX}/bin/box", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'box' to get started.\n"
  end
end
