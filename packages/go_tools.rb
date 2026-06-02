require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.45.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5792d13307485a68048df47a93ef23b6ce0aa2bdc9c61202906f3b3aebf0cfc5',
     armv7l: '5792d13307485a68048df47a93ef23b6ce0aa2bdc9c61202906f3b3aebf0cfc5',
       i686: '5acdf01f3d1e6bd6014f8ecd2e8a3ccdb4389f684e94d8906cf9e62c2d73b616',
     x86_64: 'd9939997f73171866d6df18d8c3edc7ae120e8a35bb5d30e6b8ec2b8cadf27b3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
