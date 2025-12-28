require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.80.4'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '1e9477b10295ea375e9cc460d7caa81991782125f06769798cb63ddaa130fdaa',
     armv7l: '1e9477b10295ea375e9cc460d7caa81991782125f06769798cb63ddaa130fdaa',
       i686: '7b24ebf2cc25981b1dba18d7349de8f7aa892ea66fa2be1e35dde4c9ce4d8e28',
     x86_64: '1675ca17511d67042f3ec20a383b9395da8e1b68d18d4f7eb038043c19ce0a91'
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
