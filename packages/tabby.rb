require 'package'

class Tabby < Package
  description 'Tabby is an infinitely customizable cross-platform terminal app for local shells, serial, SSH and Telnet connections.'
  homepage 'https://tabby.sh/'
  version '1.0.233'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     armv7l: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     x86_64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '117965a7047511609cb7aee3c07c4cbfb98ade67f8b8577997fecf1fa861fe7c',
     armv7l: '117965a7047511609cb7aee3c07c4cbfb98ade67f8b8577997fecf1fa861fe7c',
     x86_64: '776f0b7b40689d757917f69124882c2e2c2c0959c80715b391c87ebb436d7540'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'gtk3' # R
  depends_on 'nss' # R

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/tabby"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/tabby"
    FileUtils.ln_s "#{CREW_PREFIX}/share/tabby/tabby", "#{CREW_DEST_PREFIX}/bin/tabby"
  end
end
