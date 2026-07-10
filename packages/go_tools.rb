require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.48.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24e79314eff0a5d665ea6301f226266aaf5d146490ce601a9fcd15917fdc35e8',
     armv7l: '24e79314eff0a5d665ea6301f226266aaf5d146490ce601a9fcd15917fdc35e8',
       i686: '6d36a4a8aec6443498430bd5b293517414a999ee44726413f4db9409d05b749a',
     x86_64: 'd20a9745e03502521b17f19fa0ddc9ec3bfdcf8aa3c350b14bc57cd6e3172798'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
