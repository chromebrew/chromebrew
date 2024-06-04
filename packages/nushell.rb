require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.94.2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.28'
  source_url({
    aarch64: 'https://github.com/nushell/nushell/releases/download/0.94.2/nu-0.94.2-armv7-unknown-linux-gnueabihf.tar.gz',
     armv7l: 'https://github.com/nushell/nushell/releases/download/0.94.2/nu-0.94.2-armv7-unknown-linux-gnueabihf.tar.gz',
     x86_64: 'https://github.com/nushell/nushell/releases/download/0.94.2/nu-0.94.2-x86_64-unknown-linux-gnu.tar.gz'
  })
  source_sha256({
    aarch64: 'cadef28bcf27a8d80a4fbfa1bccb3917508199830d000e4f227bfe14957d5ad0',
     armv7l: 'cadef28bcf27a8d80a4fbfa1bccb3917508199830d000e4f227bfe14957d5ad0',
     x86_64: 'afe8f0e304a3e1299823b84a4ac5796f0e40dc8face9e0f583bdc2ed3180df80'
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
