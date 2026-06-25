require 'package'

class Delve < Package
  description 'Debugger for the Go programming language'
  homepage 'https://github.com/go-delve/delve'
  version '1.27.0'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'c295dc350f1f7d5e1f3b97541f3b8a823407d8689728a39ccfcd36ac0c9ba588',
     x86_64: '939d10701a1c92171e24555cdb368aa919662f7ee348122022cda952e18cea4b'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/go-delve/delve/cmd/dlv@v#{version}"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dlv' to get started.\n"
  end
end
