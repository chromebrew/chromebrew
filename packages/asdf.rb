require 'package'

class Asdf < Package
  description 'Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more'
  homepage 'https://asdf-vm.com/'
  version '0.16.7'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-amd64.tar.gz",
      i686: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-386.tar.gz"
  })
  source_sha256({
    x86_64: '6a5f56833da9e94068f3e70d5ca6ffe0a14a0887e1eac1b9b0c96f67d96242be',
      i686: '8889bed9d9cdf4e6c4405280ad98ef97256924cacff5c9d17c416ad7d33617a5'
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
