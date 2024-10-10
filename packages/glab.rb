require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.46.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_i386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '2cfa1714e8f9294769f432efcda682717587a2de0dbfcd0c735d77e80daa3c8b',
     armv7l: '2cfa1714e8f9294769f432efcda682717587a2de0dbfcd0c735d77e80daa3c8b',
       i686: '48f319febd9020ba681b17ba262f749b50b7f6d4af0ef736bfbea220c81e0d64',
     x86_64: 'f7e83a1ed07ab01acfca094b64a4160c074662aea83890481002b840c9f79524'
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
