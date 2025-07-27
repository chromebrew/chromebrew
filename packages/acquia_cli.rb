require 'package'

class Acquia_cli < Package
  description 'Acquia CLI - The official command-line tool for interacting with the Drupal Cloud Platform and services.'
  homepage 'https://github.com/acquia/cli'
  version '2.44.2'
  license 'GPL-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/acquia/cli/releases/download/#{version}/acli.phar"
  source_sha256 '9c7b73df5f7701014124a5afa895b086b24ac78e9caef3fbb20b311da5ccf7ce'

  depends_on 'php83' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.preflight
    major = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f1`
    minor = `php -v 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f2`
    abort "acli requires php >= 8.2. php#{major.chomp}#{minor.chomp} does not meet the minimum requirement.".lightred unless major.empty? || minor.empty? || ((major.to_i >= 8) && (minor.to_i >= 2))
  end

  def self.install
    FileUtils.install 'acli.phar', "#{CREW_DEST_PREFIX}/bin/acli", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'acli' to get started.\n"
  end
end
