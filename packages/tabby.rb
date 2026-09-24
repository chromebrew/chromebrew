require 'package'

class Tabby < Package
  description 'Tabby is an infinitely customizable cross-platform terminal app for local shells, serial, SSH and Telnet connections.'
  homepage 'https://tabby.sh/'
  version '1.0.236'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     armv7l: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     x86_64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: 'bcd7eac4dc024e4d0fff3dcbbeaa37434e55e586d8fd9a54444334d85f02db56',
     armv7l: 'bcd7eac4dc024e4d0fff3dcbbeaa37434e55e586d8fd9a54444334d85f02db56',
     x86_64: '852d788b0914c18c19d067529b92eb7c2be5754b797878f1df825f7089744bb1'
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
