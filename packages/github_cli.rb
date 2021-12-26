require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.4.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/cli/cli.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/github_cli/2.4.0_armv7l/github_cli-2.4.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/github_cli/2.4.0_armv7l/github_cli-2.4.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/github_cli/2.4.0_i686/github_cli-2.4.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/github_cli/2.4.0_x86_64/github_cli-2.4.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ed4d15c5f5463c3e32154794546d2e5bef9fa0243244b75f4f0830b67fa538e6',
     armv7l: 'ed4d15c5f5463c3e32154794546d2e5bef9fa0243244b75f4f0830b67fa538e6',
       i686: '70b4a04ba267fabcc8c2a31ca83e707ab7840797f5b8b83e54023ac1ff657f86',
     x86_64: 'e9b0e62bcbedde56e3ffc7e2e32fade7af6c3de1848c557c36ee738c3be8275d'
  })

  depends_on 'go' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm755 bin/gh #{CREW_DEST_PREFIX}/bin/gh"
  end
end
