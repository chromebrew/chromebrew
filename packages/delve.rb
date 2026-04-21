require 'package'

class Delve < Package
  description 'Debugger for the Go programming language'
  homepage 'https://github.com/go-delve/delve'
  version '1.26.2'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '34cf5a6bcc257b1213ae03911e2b05469b2fe3072c94211dfb7d35f08aa1453c',
     x86_64: 'd1f26e4a8457ed625da83f1ede84c958b321315d8360594b85d0dd8279ce85b3'
  })

  depends_on 'glibc' => :executable
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/go-delve/delve/cmd/dlv@v#{version}"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dlv' to get started.\n"
  end
end
