require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '3.71.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "curl -#LO https://github.com/platformsh/platformsh-cli/releases/download/v#{version}/platform.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('platform.phar') ) == '05caf428a7bc4c9bb841e6310f3d6d3c07599bf6f128e4d28dc8f36429d1f759'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
