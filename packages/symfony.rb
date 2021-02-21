require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '4.22.0'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm'
      sha256 = '046556c80a484a099163d1234f3ee7d6ee87ac4f6b227f56310f8c3a9141da9c'
    when 'i686'
      arch = '386'
      sha256 = '07d48c26714b8c6775a0b079d33ac386c142ff0bd91e1c6647ad6b1a76b532ee'
    when 'x86_64'
      arch = 'amd64'
      sha256 = '99cb1834bba250ccfaf0ad0689c124977d36ae03a7805d78e36c79b8da0da118'
    end
    symfony_file = "symfony_linux_#{arch}"
    system "wget https://github.com/symfony/cli/releases/download/v#{version}/#{symfony_file}"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(symfony_file) ) == sha256
    system "install -Dm755 #{symfony_file} #{CREW_DEST_PREFIX}/bin/symfony"
  end

  def self.postinstall
    puts
    puts 'Installing shell auto-completion...'.lightblue
    system 'symfony self:shell-setup --silent'
    puts
  end
end
