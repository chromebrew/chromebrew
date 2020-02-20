require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.42.1'
  case ARCH
  when 'aarch64'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.42.1/VSCodium-linux-arm64-1.42.1.tar.gz'
    source_sha256 'e40af11260dfe851510272c5ecb22cdbb65bbee6545eba841bdcc81165aada27'
    @arch = 'arm64'
  when 'armv7l'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.42.1/VSCodium-linux-arm-1.42.1.tar.gz'
    source_sha256 '4406e67781b543b2d1b8a25b038a675d94bd778c1d95356ca4abbcfe2758ea21'
    @arch = 'arm'
  when 'x86_64'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.42.1/VSCodium-linux-x64-1.42.1.tar.gz'
    source_sha256 'be05377a2a88a3167e3959cf312c55a404314be30df96d7df543e87b761e4cdd'
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
