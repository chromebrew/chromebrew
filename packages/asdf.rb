require 'package'

class Asdf < Package
  description 'Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more'
  homepage 'https://asdf-vm.com/'
  version '0.18.1'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url({
    x86_64: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-amd64.tar.gz",
      i686: "https://github.com/asdf-vm/asdf/releases/download/v#{version}/asdf-v#{version}-linux-386.tar.gz"
  })
  source_sha256({
    x86_64: '56141dc99eab75c140dcdd85cf73f3b82fed2485a8dccd4f11a4dc5cbcb6ea5c',
      i686: '54ee2e51cde039f28da1545feda085dc347fef113250b08f81b301cf832c0c19'
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
