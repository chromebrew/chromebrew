require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.50.1'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.50.1/VSCodium-linux-armhf-1.50.1.tar.gz'
    source_sha256 '185d2b40af7d5b1222a69824e9b4e6b502dc980cb0684389dc0ecf6dab0485b0'
    @arch = 'arm'
  when 'x86_64'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.50.1/VSCodium-linux-x64-1.50.1.tar.gz'
    source_sha256 '601b7b79f8b1008e0a3d64ddab55cfcb270f967f7589706ff5c940e5038c59e9'
    @arch = 'x64'
  end

  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    depends_on 'gtk2'
    depends_on 'libsecret'
    depends_on 'libgconf'
    depends_on 'xdg_base'
    depends_on 'sommelier'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/VSCodium-linux-#{@arch}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/VSCodium-linux-#{@arch}"
    FileUtils.ln_s "../VSCodium-linux-#{@arch}/bin/codium", "#{CREW_DEST_PREFIX}/bin/codium"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed VSCodium on Chrome OS!'.lightgreen
    puts 'Type \'codium\' to get started.'.lightgreen
    puts 'Happy coding!'.lightgreen
    puts
  end
end
