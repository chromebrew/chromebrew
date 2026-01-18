require 'package'

class Tssh < Package
  description 'Alternative ssh client with additional features.'
  homepage 'https://trzsz.github.io/ssh'
  version '0.1.24'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/trzsz/trzsz-ssh.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f197490536feab3eda8219bcd31ee26c961c091ba26ee34a091f8e23eac16cbb',
     armv7l: 'f197490536feab3eda8219bcd31ee26c961c091ba26ee34a091f8e23eac16cbb',
       i686: '0613c398ef5a1790942c6508a45bc8bb31ac0f3c488e14201521fee22d3ec915',
     x86_64: '1aa6ef20c85dc24b10360380f2eef5acc0b3ac8514ecb9f6de9c8a486604e288'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "go build -ldflags '-s -w' -o #{CREW_DEST_PREFIX}/bin/tssh ./cmd/tssh"
  end
end
