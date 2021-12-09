require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '4.26.11'
  license 'Symfony-cli-EULA'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm'
      sha256 = '7ca196fdc086442098fc9e9d717e276d1729975390e9cd8b42879de27f8c539d'
    when 'i686'
      arch = '386'
      sha256 = 'cb6bd321c495f1989ea5af0acbf5000d21de710eebdc31cb5a7561ee8251935c'
    when 'x86_64'
      arch = 'amd64'
      sha256 = '4c5ab4d2455eea7fba226ddabba32a67b16828ec0e1977588045061a7a0a3a7a'
    end
    symfony_file = "symfony_linux_#{arch}"
    system "curl -#LO https://github.com/symfony/cli/releases/download/v#{version}/#{symfony_file}"
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
