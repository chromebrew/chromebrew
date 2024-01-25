require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.88.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.28'
  source_url({
    aarch64: 'https://github.com/nushell/nushell/releases/download/0.88.0/nu-0.88.0-armv7-unknown-linux-gnueabihf.tar.gz',
     armv7l: 'https://github.com/nushell/nushell/releases/download/0.88.0/nu-0.88.0-armv7-unknown-linux-gnueabihf.tar.gz',
     x86_64: 'https://github.com/nushell/nushell/releases/download/0.88.0/nu-0.88.0-x86_64-unknown-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: '81a8a45ae50c8574ea59017e71ba8be56b13899fb16477c97be50d56beb1d17e',
     armv7l: '81a8a45ae50c8574ea59017e71ba8be56b13899fb16477c97be50d56beb1d17e',
     x86_64: 'f9359784ad6f09e840bc2b6fbb6b7d17964109009d7ad460c16db30ef0cea414'
  })

  no_compile_needed
  no_shrink

  def self.install
    Dir['nu*'].each do |bin|
      FileUtils.install bin, "#{CREW_DEST_PREFIX}/bin/#{bin}", mode: 0o755
    end
  end

  def self.postinstall
    puts "\nType 'nu' to get started.\n".lightblue
  end
end
