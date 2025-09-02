require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.36.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c938388e815f2d03343301f391640a1cbc11fac3b31e20fc74b77c0963723df',
     armv7l: '5c938388e815f2d03343301f391640a1cbc11fac3b31e20fc74b77c0963723df',
       i686: '02e41321fa7030598a80a396887289027889ad08784bf04c68f38196f33f02ec',
     x86_64: '9436c12f13b3b60f1b3897434b923d944a4709b4855256060379a206656407b8'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
