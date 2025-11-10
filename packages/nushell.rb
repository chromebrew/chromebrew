require 'package'

class Nushell < Package
  description 'A new type of shell'
  homepage 'https://www.nushell.sh/'
  version '0.108.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/nushell/nushell/releases/download/#{version}/nu-#{version}-x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '5823f3b115fd4fd303cc5dcc316d07e7afeee74b0d9937ee380d40b97c3d13d9',
     armv7l: '5823f3b115fd4fd303cc5dcc316d07e7afeee74b0d9937ee380d40b97c3d13d9',
     x86_64: 'f0daaa0256b0f7dd5f4d9925b4d5522d8de5e947ed9ad64a43526e5cffeb05df'
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
