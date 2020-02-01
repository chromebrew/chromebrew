require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.43.1-1'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.43.1/VSCodium-linux-arm-1.43.1.tar.gz'
    source_sha256 '9284f85c832441b20462843acaa69da9b1efd8407a5818c78e415e39f13f9cb7'
    @arch = 'arm'
  when 'x86_64'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.43.1/VSCodium-linux-x64-1.43.1.tar.gz'
    source_sha256 '5a8c67b3da103baaa843797d4dc487c167c9068ae99181d8f483baf632ef5975'
    @arch = 'x64'
  end

  depends_on 'gtk2'
  depends_on 'libsecret'
  depends_on 'libgconf'
  depends_on 'xdg_base'
  depends_on 'sommelier'

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
