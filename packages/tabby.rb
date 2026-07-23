require 'package'

class Tabby < Package
  description 'Tabby is an infinitely customizable cross-platform terminal app for local shells, serial, SSH and Telnet connections.'
  homepage 'https://tabby.sh/'
  version '1.0.235'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     armv7l: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     x86_64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: 'e81e0643c17a888a92c71d39bcb59287a28c69a0a5cade286063d5e5c0f11099',
     armv7l: 'e81e0643c17a888a92c71d39bcb59287a28c69a0a5cade286063d5e5c0f11099',
     x86_64: 'af194d1c0ead7c190127aa911a56052ba088be085b1f6d8526a97f30db14962b'
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
