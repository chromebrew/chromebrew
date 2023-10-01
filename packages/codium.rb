require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.82.2.23257'
  license 'MIT'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-armhf-#{version}.tar.gz"
    source_sha256 '966d46957770746c29271879f285cdc2cdc3f59ad6b9ed8046d28c65bcca6a43'
    @arch = 'arm'
  when 'x86_64'
    source_url "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-x64-#{version}.tar.gz"
    source_sha256 'c372d9872a30e7feddba9c5c732ab63e9b78b223855d11a1a2ab3bfce776f5f7'
    @arch = 'x64'
  end

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cups' # R
  depends_on 'dbus' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libdrm' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxkbfile' # R
  depends_on 'libxrandr' # R
  depends_on 'mesa' # R
  depends_on 'nss' # R
  depends_on 'pango' # R
  depends_on 'sommelier' # L

  no_fhs
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/VSCodium-linux-#{@arch}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/VSCodium-linux-#{@arch}"
    FileUtils.ln_s "../VSCodium-linux-#{@arch}/bin/codium", "#{CREW_DEST_PREFIX}/bin/codium"
  end

  def self.postinstall
    puts "\nCongratulations! You have installed VSCodium!".lightgreen
    puts "Type 'codium' to get started.".lightgreen
    puts "Happy coding!\n".lightgreen
  end
end
