require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.55.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '9d8bce276d9383237057aa6ed675a5940137d318c2f4e65928ab64c113d073fc',
     armv7l: '9d8bce276d9383237057aa6ed675a5940137d318c2f4e65928ab64c113d073fc',
       i686: '76dc368485a27bd152331112ef032eb763b88206d299386876b5a71f32b0eb45',
     x86_64: '9cc9638b82f84c0fb18b7af48dcb9f8590e6bc91658752e57bccce12fcc56a49'
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
