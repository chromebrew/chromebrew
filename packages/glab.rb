require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.100.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'e3719a7ff6dee1525b2ac3fbddb1e1cf2ac8573eb5b54fa7f639602e97bc5942',
     armv7l: 'e3719a7ff6dee1525b2ac3fbddb1e1cf2ac8573eb5b54fa7f639602e97bc5942',
       i686: '1fcf4a4f4d3d1b313c2d62e608d669b22ee2bbb1fa2c482cd3b201a8727b4c24',
     x86_64: 'd2a8ccffe924d3ad22feb2d1338840e9a610041c6ea6fd76e9aeda3744f210c2'
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
