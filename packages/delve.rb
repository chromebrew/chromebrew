require 'package'

class Delve < Package
  description 'Debugger for the Go programming language'
  homepage 'https://github.com/go-delve/delve'
  version '1.27.2'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '9f010e8f551350b1ff73abaf52094d22a6145c1a17e90f9a2bd79453bc942210',
     x86_64: 'd1904a60539b596d847ddd74c5aa8f76a33b9f20fc1dee6b7e344565b2a8d686'
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
