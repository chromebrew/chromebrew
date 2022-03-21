require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '3.77.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    system "curl -#LO https://github.com/platformsh/platformsh-cli/releases/download/v#{version}/platform.phar"
    unless Digest::SHA256.hexdigest( File.read('platform.phar') ) == '9cf3b8beb3bbeaee3de2bbd56394089812ff660749bd1d7d32886e8385338872'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'platform.phar', "#{CREW_DEST_PREFIX}/bin/platform", mode: 0o755
  end
end
