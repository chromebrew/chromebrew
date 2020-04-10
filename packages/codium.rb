require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.44.0'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.44.0/VSCodium-linux-arm-1.44.0.tar.gz'
    source_sha256 '314ee25c1c8f86eb1d144b36b9f251de875fe2807c86bf5564a452662c3deac2'
    @arch = 'arm'
  when 'x86_64'
    source_url 'https://github.com/VSCodium/vscodium/releases/download/1.44.0/VSCodium-linux-x64-1.44.0.tar.gz'
    source_sha256 '0f842932e6a4db3510a171a54aac457f96fc4f6a75562b8d2e20fd927f263bdf'
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
