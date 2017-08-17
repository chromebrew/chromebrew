require 'package'

class Platformsh < Package
  description 'The unified tool for managing your Platform.sh services from the command line.'
  homepage 'https://docs.platform.sh/overview/cli.html'
  version '3.19.0'
  source_url 'https://github.com/platformsh/platformsh-cli/archive/v3.19.0.tar.gz'
  source_sha256 'c8f79f2141bdf5f6bed11376da773f9d90e8b3ddc059a1159cf11a0929aa6aff'

  depends_on 'php7' unless File.exists? '/usr/local/bin/php'

  def self.install
    system "wget https://github.com/platformsh/platformsh-cli/releases/download/v3.19.0/platform.phar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('platform.phar') ) == 'ca4080182458fb18244bf8d93a36695146a737eb5acd35be56d65161af5a0dd7'
    system "chmod +x platform.phar"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp platform.phar #{CREW_DEST_DIR}/usr/local/bin/platform"
  end
end
