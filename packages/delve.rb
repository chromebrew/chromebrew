require 'package'

class Delve < Package
  description 'Debugger for the Go programming language'
  homepage 'https://github.com/go-delve/delve'
  version '1.24.1'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: '6951f4ce2b6bbf8a5246b67bfb04a4515e16a860bf9be44f0235f2d205fc3685',
     x86_64: 'cf071e94d9d66c7d072350e29e0bc6b02ac0c1913b750d7f8619ebfaeb3735f8'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/go-delve/delve/cmd/dlv@v#{version}"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dlv' to get started.\n"
  end
end
