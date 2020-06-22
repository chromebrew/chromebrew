require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.46.1'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.46.1/VSCodium-linux-arm-1.46.1.tar.gz'
    source_sha256 '52a79ad814c5b8c37899a7003047a7c7852c41edbdd2a81c4f4d3a30db84b967'
    @arch = 'arm'
  when 'x86_64'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.46.1/VSCodium-linux-x64-1.46.1.tar.gz'
    source_sha256 '471976fe4e32af3f17f1efb3d0d006e51ff09195621ecf544bf314039a783a51'
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
