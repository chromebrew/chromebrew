require 'package'

class Peco < Package
  description 'Simplistic interactive filtering tool'
  homepage 'https://github.com/peco/peco'
  version '0.5.11'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/peco/peco.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/peco/0.5.11_armv7l/peco-0.5.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/peco/0.5.11_armv7l/peco-0.5.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/peco/0.5.11_i686/peco-0.5.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/peco/0.5.11_x86_64/peco-0.5.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2da48435de834d1365e1d6080babe514c6adf7ae1d70f04ee2bad71009730c6b',
     armv7l: '2da48435de834d1365e1d6080babe514c6adf7ae1d70f04ee2bad71009730c6b',
       i686: 'cf7949ba4b021bfeeaa3b3c06a0d8b0ded4c3bafeb7fa6ef73b9c32494fd47f4',
     x86_64: '7bfddfa8261c705a5bc5ffa1802845eb251e208025864df34271e2e4ca9b7f6c'
  })

  depends_on 'go' => :build

  def self.install
    system 'make build'
    system "go build -o #{CREW_DEST_PREFIX}/bin/peco cmd/peco/peco.go"
  end
end
