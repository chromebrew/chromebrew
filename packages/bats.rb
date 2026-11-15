require 'package'

class Bats < Package
  description 'Bash Automated Testing System'
  homepage 'https://github.com/bats-core/bats-core'
  version '1.14.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/bats-core/bats-core.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '547f34298cf4b94e799e02f05ce42a49d82dd5131e5939eca7d4d79082262bb6',
     armv7l: '547f34298cf4b94e799e02f05ce42a49d82dd5131e5939eca7d4d79082262bb6',
       i686: '7d924a856b66296fb3e134990e61579399ecc3d6c55d57bba06ac5397747a700',
     x86_64: '597df5d0be67f5f1d6c6630b0029c2a55f35d22dc743308700892a3f99bd1921'
  })

  def self.install
    system "./install.sh #{CREW_DEST_PREFIX} #{ARCH_LIB}"
  end
end
