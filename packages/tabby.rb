require 'package'

class Tabby < Package
  description 'Tabby is an infinitely customizable cross-platform terminal app for local shells, serial, SSH and Telnet connections.'
  homepage 'https://tabby.sh/'
  version '1.0.208'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     armv7l: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-armv7l.tar.gz",
     x86_64: "https://github.com/Eugeny/tabby/releases/download/v#{version}/tabby-#{version}-linux-x64.tar.gz"
  })
  source_sha256({
    aarch64: '475ad3658768642158c1af85f92fa45b381ade8ddfc65c4430df58dda581988a',
     armv7l: '475ad3658768642158c1af85f92fa45b381ade8ddfc65c4430df58dda581988a',
     x86_64: 'c30d8c0c26e8d6d9f4d173ad79668ca9e4fccd521850c0df8bfb222df65edcff'
  })

  depends_on 'at_spi2_core'
  depends_on 'gtk3'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/tabby"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/tabby"
    FileUtils.ln_s "#{CREW_PREFIX}/share/tabby/tabby", "#{CREW_DEST_PREFIX}/bin/tabby"
  end
end
