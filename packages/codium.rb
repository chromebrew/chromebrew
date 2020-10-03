require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    version '1.49.1'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.49.1/VSCodium-linux-arm-1.49.1.tar.gz'
    source_sha256 '6534d7b10b13a1effadf408899c90a23a8a499298d686a3e8e74535c186a6b65'
    @arch = 'arm'
  when 'x86_64'
    version '1.49.3'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.49.3/VSCodium-linux-x64-1.49.3.tar.gz'
    source_sha256 'd8b71d50d82e8d3151f11604103a7fd3fff3a2dceec64a31e1a3683a9d2fc2a7'
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
