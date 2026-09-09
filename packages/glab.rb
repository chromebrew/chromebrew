require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.117.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'ba9223ed101b8fce9d4787c77243fbe050d97bc4f9c39cf22d864c1fca5ca81c',
     armv7l: 'ba9223ed101b8fce9d4787c77243fbe050d97bc4f9c39cf22d864c1fca5ca81c',
       i686: 'd726fba3dbc2a3dcae903534908dd1e076d38cbb54f209841d71d2b27466c659',
     x86_64: '1edfd0fba284e93396a9fd8899b9fff10f34f90b733943b1a70e21431a1991ab'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bin/glab', "#{CREW_DEST_PREFIX}/bin/glab", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'glab' to get started.\n"
  end
end
