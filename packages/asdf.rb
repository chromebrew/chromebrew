require 'package'

class Asdf < Package
  description 'Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more'
  homepage 'https://asdf-vm.com/'
  version '0.20.2'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-amd64.tar.gz",
      i686: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-386.tar.gz"
  })
  source_sha256({
    x86_64: '6d45e6fab12f50a259b5643adf06a2e77af30a87300b4402440eda09af467a6d',
      i686: '140141311f21a25882a1d2c419771449ed5dec1fffb01d323c115e741f3c3719'
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
