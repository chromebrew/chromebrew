require 'package'

class Delve < Package
  description 'Debugger for the Go programming language'
  homepage 'https://github.com/go-delve/delve'
  version '1.26.1'
  license 'MIT'
  compatibility 'i686 x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'a566eec3b08e17c43f7f3d9e652b4fcbc2f6f673f36a5fa107500d40b505666d',
     x86_64: 'dda2b038b2dcde6884f3633548b9b5de230645fb5a1fa859ab9cdaa5ad34c599'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'go' => :build

  no_source_build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install github.com/go-delve/delve/cmd/dlv@v#{version}"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dlv' to get started.\n"
  end
end
