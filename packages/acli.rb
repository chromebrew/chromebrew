require 'package'

class Acli < Package
  description 'Acquia CLI - The official command-line tool for interacting with the Drupal Cloud Platform and services.'
  homepage 'https://github.com/acquia/cli'
  version '2.2.0'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.preflight
    major = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f1`
    minor = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f2`
    unless major.empty? or minor.empty? or (major.to_i >= 8 and minor.to_i >= 0)
      abort "acli requires php >= 8.0. php #{major.chomp}.#{minor.chomp} does not meet the minimum requirement.".lightred
    end
  end

  def self.install
    downloader "https://github.com/acquia/cli/releases/download/#{version}/acli.phar",
               '374f024ef474e5642ef424820f6ecdebb30f2f89535fdab400e6b61e238b85a6'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'acli.phar', "#{CREW_DEST_PREFIX}/bin/acli", mode: 0o755
  end
end
