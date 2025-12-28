require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.109.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'd326d4763ddb4ae2b3a5542f1a6f67d4c578575a9ec69e00bbc892d60b2b1232',
     armv7l: 'd326d4763ddb4ae2b3a5542f1a6f67d4c578575a9ec69e00bbc892d60b2b1232',
     x86_64: '0fa23b828ac610e3ee7798b25e38cef5cfdc47503326236d27cd57d1c959190e'
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
