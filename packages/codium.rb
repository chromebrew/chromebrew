require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.66.0'
  license 'MIT'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-armhf-#{version}.tar.gz"
    source_sha256 'e34388825fc7469c5a9ea903cd3ed46e44d8e492605078ac04da90994dc5c9e7'
    @arch = 'arm'
  when 'x86_64'
    source_url "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-x64-#{version}.tar.gz"
    source_sha256 'd6e12dceff13c9d8b9c6ce13dd6d39c89cae1f81ef3f22fbb185b85e51446237'
    @arch = 'x64'
  end

  depends_on 'alsa_lib'
  depends_on 'atk'
  depends_on 'at_spi2_atk'
  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'dbus'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'libcom_err'
  depends_on 'libdrm'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxcomposite'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxkbcommon'
  depends_on 'libxkbfile'
  depends_on 'libxrandr'
  depends_on 'mesa'
  depends_on 'nspr'
  depends_on 'nss'
  depends_on 'pango'
  depends_on 'sommelier'

  def self.install
    ENV['CREW_NOT_SHRINK_ARCHIVE'] = '1'
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    reload_constants
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
