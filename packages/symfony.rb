require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '4.13.3'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm'
      sha256 = '7fed4138ee75f6b68e034760acd3ad9e0b95a41ab052a8454148891d8389670d'
    when 'i686'
      arch = '386'
      sha256 = 'acafc620d486b7aff8d21adff32655c6b4db7f74f46248d0830ce5b93d324dbc'
    when 'x86_64'
      arch = 'amd64'
      sha256 = '63a86004121244dc2ae1cef86ffe16c80e272c2b2f99397b9222390eb85426a2'
    end
    system "wget https://github.com/symfony/cli/releases/download/v#{version}/symfony_linux_#{arch}"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("symfony_linux_#{arch}") ) == sha256
    system "install -Dm755 symfony_linux_#{arch} #{CREW_DEST_PREFIX}/bin/symfony"
  end

  def self.postinstall
    puts
    puts 'Installing shell auto-completion...'.lightblue
    system 'symfony self:shell-setup --silent'
    puts
  end
end
