require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.43.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_i386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '99a41fa0aaa70f72c9ed0c9e1dd40438058bce3a0a6ca68658d74b670d1e09e7',
     armv7l: '99a41fa0aaa70f72c9ed0c9e1dd40438058bce3a0a6ca68658d74b670d1e09e7',
       i686: 'c76f5fb151f7b828cb842c9bd0d33cd55d108369bfdce8732a04a0b98a1ad9fe',
     x86_64: '0d4424819c5b9c35063ac387da5e26e00eedfe76c491bb83196dfe64cc456830'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bin/glab', "#{CREW_DEST_PREFIX}/bin/glab", mode: 0o755
  end
end
