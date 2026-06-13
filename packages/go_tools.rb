require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.46.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '029af1c9763504d4953a8f064f2ee5612b1b7db25bd8b4e33c22808c14ea7ca0',
     armv7l: '029af1c9763504d4953a8f064f2ee5612b1b7db25bd8b4e33c22808c14ea7ca0',
       i686: '40d1d67dbdbb1be7f4d63c9f46a72a5a1c43a0db5680a70e2e86f1ca72974b2f',
     x86_64: 'a6a730cb968f1da271a80e5e12231fba6f739e22d20000c92e84a47fa22dac04'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
