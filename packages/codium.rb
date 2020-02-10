require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.42.0-1'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.42.0/VSCodium-linux-arm-1.42.0.tar.gz'
    source_sha256 '85745764ea7f541f9adb76d98a6675563fcc02d0cf8515f58600867f5f1fc377'
    @arch = 'arm'
  when 'x86_64'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.42.0/VSCodium-linux-x64-1.42.0.tar.gz'
    source_sha256 'b83425865394d6414ea22aa065a4b2413e93acf63b97f973743c69c38960d138'
    @arch = 'x64'
  end

  depends_on 'gtk2'
  depends_on 'libsecret'
  depends_on 'libgconf'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/VSCodium-linux-#{@arch}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/VSCodium-linux-#{@arch}"
    FileUtils.ln_s "../share/VSCodium-linux-#{@arch}/bin/codium", "#{CREW_DEST_PREFIX}/bin/codium"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed VSCodium on Chrome OS!'.lightgreen
    puts 'Now, please type \'codium\' to execute.'.lightgreen
    puts 'Happy coding!'.lightgreen
    puts
  end
end
