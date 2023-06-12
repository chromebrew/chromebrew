require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.30.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.30.0/downloads/glab_1.30.0_Linux_armv6.tar.gz',
     armv7l: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.30.0/downloads/glab_1.30.0_Linux_armv6.tar.gz',
       i686: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.30.0/downloads/glab_1.30.0_Linux_i386.tar.gz',
     x86_64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.30.0/downloads/glab_1.30.0_Linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: 'f12fa342eda1a1af512bc7552d852249424d9dd9e46db976a1cfad0ce1bff598',
     armv7l: 'f12fa342eda1a1af512bc7552d852249424d9dd9e46db976a1cfad0ce1bff598',
       i686: '61a9d0de87a59aedc0fa191f13afa875ffb9f67c07ef1781b06630063182cc81',
     x86_64: 'e578cefe5d5c38d0ec0fed44da9a85fe9a8bdf055b0822aa1d0a89e5dd014614'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bin/glab', "#{CREW_DEST_PREFIX}/bin/glab", mode: 0o755
  end
end
