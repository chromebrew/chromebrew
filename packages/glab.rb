require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.46.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_i386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'ac0687487e7efbabc1d9c527b63a173900ee51ca7fd7932e6eec822e0627af6e',
     armv7l: 'ac0687487e7efbabc1d9c527b63a173900ee51ca7fd7932e6eec822e0627af6e',
       i686: '25f2d99934965aa7207483a8afc2c1b7eeb7a496f9e773ef394fd11e4be9ab92',
     x86_64: '1e26ca89cf649cd9326b901660417d312aad415ba9aff87271b9b16bb5c8232f'
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
