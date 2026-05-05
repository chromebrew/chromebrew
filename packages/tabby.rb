require 'package'

class Tabby < Package
  description 'Tabby is an infinitely customizable cross-platform terminal app for local shells, serial, SSH and Telnet connections.'
  homepage 'https://tabby.sh/'
  version '1.0.232'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     armv7l: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     x86_64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '8915243031bab8f94f128fa5ed4da03bf3aca64cc138738964db391f9fb3b13a',
     armv7l: '8915243031bab8f94f128fa5ed4da03bf3aca64cc138738964db391f9fb3b13a',
     x86_64: '50f582686d25f0a3504c3cdd7ce5b33a0a0ce822a8c669eea0f7a4e464d8635c'
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
