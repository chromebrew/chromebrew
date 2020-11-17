require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '4.20.3'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm'
      sha256 = 'd5113c6eaf24debbc1fe2734d97c80a8929a134e992c3e82095b3839c4d282a9'
    when 'i686'
      arch = '386'
      sha256 = '1f2dfb4a51f3cd3ecece702f9639fd9510694307df0dc882c72cbad4a05c73b5'
    when 'x86_64'
      arch = 'amd64'
      sha256 = 'd593f2da39bdcdb753fc81721613c2ad0db5c0a01d1e31fb63324d95384afa12'
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
