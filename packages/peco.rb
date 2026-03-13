require 'package'

class Peco < Package
  description 'Simplistic interactive filtering tool'
  homepage 'https://github.com/peco/peco'
  version '0.6.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/peco/peco.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '824b8568e54f044f07176ed2378cbf7d9567d7bd7e35bf62d1c917236a3b5306',
     armv7l: '824b8568e54f044f07176ed2378cbf7d9567d7bd7e35bf62d1c917236a3b5306',
       i686: 'a965a51598801382c319ed078cc05e0dc374526591079303947c007bb16684cc',
     x86_64: '795abcddad3f4713fce15baa93cffc3ece5f223ff19abd588589409eebe12010'
  })

  depends_on 'go' => :build

  def self.install
    system "go build -o #{CREW_DEST_PREFIX}/bin/peco cmd/peco/peco.go"
  end
end
