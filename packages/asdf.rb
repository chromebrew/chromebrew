require 'package'

class Asdf < Package
  description 'Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more'
  homepage 'https://asdf-vm.com/'
  version '0.19.0'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-amd64.tar.gz",
      i686: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-386.tar.gz"
  })
  source_sha256({
    x86_64: 'f6aa14de1348c9a85f3095f79792a5cd04305c466e6458c69a36a1621cd729ef',
      i686: 'd7ebfce73b277bed38f8d8d38c056978e5051baf1ea51ae661620f5db4693808'
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
