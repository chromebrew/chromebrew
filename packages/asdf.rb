require 'package'

class Asdf < Package
  description 'Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more'
  homepage 'https://asdf-vm.com/'
  version '0.18.0'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-amd64.tar.gz",
      i686: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-386.tar.gz"
  })
  source_sha256({
    x86_64: '4d3007070166cb0a652af26c3f0462b021e04cb26c4ab13894d13689da89f5b8',
      i686: 'ebb2530d98806a0a4746f2b1f57910a962133e55c2c60d81957887166da947f7'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'asdf', "#{CREW_DEST_PREFIX}/bin/asdf", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'asdf' to get started.\n"
  end
end
