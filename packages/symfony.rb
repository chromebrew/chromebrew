require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '4.28.1'
  license 'Symfony-cli-EULA'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm'
      sha256 = '01a872cdfd33db4216e73e6c9a56ef4c63799d1feb119e57c51141aca121b85c'
    when 'i686'
      arch = '386'
      sha256 = 'c51c2be1b1f82c572777fd5fc2bb55e553c58309f7ffc7b14a1aace02e2359e8'
    when 'x86_64'
      arch = 'amd64'
      sha256 = '66c2daf21e3acbdda8d826a0484b02e59255401d54027cdbe2605406f77933a8'
    end
    symfony_file = "symfony_linux_#{arch}"
    downloader "https://github.com/symfony/cli/releases/download/v#{version}/#{symfony_file}"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(symfony_file) ) == sha256
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install symfony_file, "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end

  def self.postinstall
    puts
    puts 'Installing shell auto-completion...'.lightblue
    system 'symfony self:shell-setup --silent'
    puts
  end
end
