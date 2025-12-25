require 'package'

class Vscodium < Package
  description 'VSCodium is Open Source Software Binaries of VSCode with a community-driven default configuration.'
  homepage 'https://vscodium.com/'
  version '1.107.18605'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-armhf-#{version}.tar.gz",
     armv7l: "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-armhf-#{version}.tar.gz",
     x86_64: "https://github.com/VSCodium/vscodium/releases/download/#{version}/VSCodium-linux-x64-#{version}.tar.gz"
  })
  source_sha256({
    aarch64: '1aa286260582156b3b2313fcd7d92a35041eb223d6980ecc6a3711e2c85a4163',
     armv7l: '1aa286260582156b3b2313fcd7d92a35041eb223d6980ecc6a3711e2c85a4163',
     x86_64: '6eb0b68cdae20aa5cca73fb4e2c0cc58459e02b484aeb57d7edfe2bc21d32abd'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'dbus' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'krb5' # R
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
  no_compile_needed
  no_shrink

  def self.install
    arch = ARCH == 'x86_64' ? 'x64' : 'arm'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/VSCodium-linux-#{arch}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/VSCodium-linux-#{arch}"
    FileUtils.ln_s "../VSCodium-linux-#{arch}/bin/codium", "#{CREW_DEST_PREFIX}/bin/codium"
  end

  def self.postinstall
    puts "\nCongratulations! You have installed VSCodium!".lightgreen
    puts "Type 'codium' to get started.".lightgreen
    puts "Happy coding!\n".lightgreen
  end
end
