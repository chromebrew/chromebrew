require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.113.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'ba8e34cf6a231590656ffb9bbc37243091680dd373e39c75375aa892b46e5280',
     armv7l: 'ba8e34cf6a231590656ffb9bbc37243091680dd373e39c75375aa892b46e5280',
     x86_64: '68c0f84254b23ed86d1582797d32f73db0969fa39297b3cc339656e634663468'
  })

  no_compile_needed
  no_shrink

  def self.install
    Dir['nu*'].each do |bin|
      FileUtils.install bin, "#{CREW_DEST_PREFIX}/bin/#{bin}", mode: 0o755
    end
  end

  def self.postinstall
    ExitMessage.add "\nType 'nu' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/nushell")
  end
end
