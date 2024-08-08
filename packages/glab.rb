require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.45.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_i386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '4821d007623912c4bb1f1dfe0e509e5f941b78c2aee1abc40fc0c7ada4523d94',
     armv7l: '4821d007623912c4bb1f1dfe0e509e5f941b78c2aee1abc40fc0c7ada4523d94',
       i686: '2bd79829643c5782e065fa1a2a80651fb5adea1d14135af0cadf133301298282',
     x86_64: '6f4100d900a5f4f72758703bc3eb3eece2d5b6147eb3a321631ffa1d873bb970'
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
