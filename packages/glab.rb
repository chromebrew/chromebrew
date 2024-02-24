require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.36.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.36.0/downloads/glab_1.36.0_Linux_armv6.tar.gz',
     armv7l: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.36.0/downloads/glab_1.36.0_Linux_armv6.tar.gz',
       i686: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.36.0/downloads/glab_1.36.0_Linux_i386.tar.gz',
     x86_64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.36.0/downloads/glab_1.36.0_Linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: 'a97116234c13098b18d585149b75bbd60e6a3949998e9652defd61ef6cd61196',
     armv7l: 'a97116234c13098b18d585149b75bbd60e6a3949998e9652defd61ef6cd61196',
       i686: 'f9c51a07f7bdc1dde27f148ec7ed482003f69e23d1738d67f5d5154a0f27c129',
     x86_64: '8dc52304797d3623b6797fd9379e44b5fc565c7a743d598e2490950abd50b304'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bin/glab', "#{CREW_DEST_PREFIX}/bin/glab", mode: 0o755
  end
end
