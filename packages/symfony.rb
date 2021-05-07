require 'package'

class Symfony < Package
  description 'Symfony is a set of PHP Components, a Web Application framework'
  homepage 'https://symfony.com/'
  version '4.23.5'
  license 'Symfony-cli-EULA'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    case ARCH
    when 'aarch64', 'armv7l'
      arch = 'arm'
      sha256 = 'abc16666f20b022ec4eeb2fddcc968e622ab7c656c69e34d41acd0ae51a99a28'
    when 'i686'
      arch = '386'
      sha256 = '65398740b4da78d312d6ecd94e8adfa4ea5d934398b18dec66e1d995332d419e'
    when 'x86_64'
      arch = 'amd64'
      sha256 = '43aef5fd5d45f4602697cad016eff504cb68ec6ad1271c7b1e2a089e1eedd05a'
    end
    symfony_file = "symfony_linux_#{arch}"
    system "curl -#LO https://github.com/symfony/cli/releases/download/v#{version}/#{symfony_file}"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read(symfony_file) ) == sha256
    FileUtils.install symfony_file, "#{CREW_DEST_PREFIX}/bin/symfony", mode: 0o755
  end

  def self.postinstall
    puts
    puts 'Installing shell auto-completion...'.lightblue
    system 'symfony self:shell-setup --silent'
    puts
  end
end
