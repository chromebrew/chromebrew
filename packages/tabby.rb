require 'package'

class Tabby < Package
  description 'Tabby is an infinitely customizable cross-platform terminal app for local shells, serial, SSH and Telnet connections.'
  homepage 'https://tabby.sh/'
  version '1.0.206'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/Eugeny/tabby/releases/download/v1.0.206/tabby-1.0.206-linux-armv7l.tar.gz',
     armv7l: 'https://github.com/Eugeny/tabby/releases/download/v1.0.206/tabby-1.0.206-linux-armv7l.tar.gz',
     x86_64: 'https://github.com/Eugeny/tabby/releases/download/v1.0.206/tabby-1.0.206-linux-x64.tar.gz'
  })
  source_sha256({
    aarch64: 'cef0057e7bc1e13ef7f24c10219a49c972351f83fe6ed6b0b78af1858449faa3',
     armv7l: 'cef0057e7bc1e13ef7f24c10219a49c972351f83fe6ed6b0b78af1858449faa3',
     x86_64: '7dd30952a5beacab28cfaccc1f2978451622843a37fd8901f79af6b107fe234b'
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
