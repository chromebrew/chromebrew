require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.40.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.40.0/downloads/glab_1.40.0_Linux_armv6.tar.gz',
     armv7l: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.40.0/downloads/glab_1.40.0_Linux_armv6.tar.gz',
       i686: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.40.0/downloads/glab_1.40.0_Linux_i386.tar.gz',
     x86_64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.40.0/downloads/glab_1.40.0_Linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: 'a166c1142b06fddfac5ed692e3462d51917451429a2deec9cbc44722bf21aba0',
     armv7l: 'a166c1142b06fddfac5ed692e3462d51917451429a2deec9cbc44722bf21aba0',
       i686: 'b0e3699d1c7d4b3c7f120682ae718182ca8ea66cb2dfd308fd71b06b396ee661',
     x86_64: 'bb0d6f64425a606f63482e93edc010e755ce67a668f56803ceb7374eb97cf138'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bin/glab', "#{CREW_DEST_PREFIX}/bin/glab", mode: 0o755
  end
end
