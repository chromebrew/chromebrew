require 'package'

class Codium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.60.0'
  license 'MIT'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-armhf-#{version}.tar.gz"
    source_sha256 '5ea249d23901ee7cd3a1ba16c138245e5bdd1e5602ba7f378a9611d394e64877'
    @arch = 'arm'
  when 'x86_64'
    source_url "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-x64-#{version}.tar.gz"
    source_sha256 '2230bfd26b325beed31575863283975be39686d1245f32b9bd8a45b4b08573d0'
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
    ENV['CREW_SHRINK_ARCHIVE'] = '0'
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
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
