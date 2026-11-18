require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.53.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05285fbb7b2590f71416bfa96b0fc3f355be242f33be9f3d06ec2065d8e9cc42',
     armv7l: '05285fbb7b2590f71416bfa96b0fc3f355be242f33be9f3d06ec2065d8e9cc42',
       i686: '7568ca0deb2377df3bb798b524a9bc48dbbd5605ae5eea42f5ade99b920adfe2',
     x86_64: '1e546bb7a94c0a2dd622f262f6da95e3692b1e47be9c610199e4ee056240c385'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
