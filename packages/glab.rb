require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.41.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.41.0/downloads/glab_1.41.0_Linux_armv6.tar.gz',
     armv7l: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.41.0/downloads/glab_1.41.0_Linux_armv6.tar.gz',
       i686: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.41.0/downloads/glab_1.41.0_Linux_i386.tar.gz',
     x86_64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.41.0/downloads/glab_1.41.0_Linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: '8cf620342b2f1c8b348dd79e26c27589047fe3be03868327f1bc68bc8e9c7734',
     armv7l: '8cf620342b2f1c8b348dd79e26c27589047fe3be03868327f1bc68bc8e9c7734',
       i686: '683745ae13394f95187469cbaffdf2ae7bb82401f555e5add3c2e03f5fef8972',
     x86_64: 'ff7775b328ec7cad64211a1573597ba8e34b9ef6bc53e0448e1dc174ca14a698'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bin/glab', "#{CREW_DEST_PREFIX}/bin/glab", mode: 0o755
  end
end
