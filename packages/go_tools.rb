require 'package'

class Go_tools < Package
  description 'Developer tools for the Go programming language'
  homepage 'https://github.com/golang/tools'
  version '0.39.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/golang/tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b16a0ea24997fbb30685c98ed7dda96a6038508a11015880be5f7df2a04011d',
     armv7l: '8b16a0ea24997fbb30685c98ed7dda96a6038508a11015880be5f7df2a04011d',
       i686: '8578feede07c22d87fcfbd644070de078ceec9e47449f774c13339b2f26645c4',
     x86_64: 'cb272fa3956a58cdca188a676e6ebd8956c969764d0bc6652bedf5c8c8a980d2'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "GOBIN=#{CREW_DEST_PREFIX}/bin go install ./cmd..."
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/bundle", "#{CREW_DEST_PREFIX}/bin/go_bundle"
  end
end
