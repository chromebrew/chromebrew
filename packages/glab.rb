require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.34.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.34.0/downloads/glab_1.34.0_Linux_armv6.tar.gz',
     armv7l: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.34.0/downloads/glab_1.34.0_Linux_armv6.tar.gz',
       i686: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.34.0/downloads/glab_1.34.0_Linux_i386.tar.gz',
     x86_64: 'https://gitlab.com/gitlab-org/cli/-/releases/v1.34.0/downloads/glab_1.34.0_Linux_x86_64.tar.gz'
  })
  source_sha256({
    aarch64: 'd7f8f60fb82d9b973d90db7db94b99d8b370a2adf4c335fe458b37fcfa8b04c6',
     armv7l: 'd7f8f60fb82d9b973d90db7db94b99d8b370a2adf4c335fe458b37fcfa8b04c6',
       i686: '45d8fa10f3cbd0d3a909e503dc3f424c122edd2a130f24ec3bcf644b8ac0e24e',
     x86_64: '0a6557e493c4dce99eb65f0832d9e5838d5f0ecc2ecfa0bd186d95943a597fac'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'bin/glab', "#{CREW_DEST_PREFIX}/bin/glab", mode: 0o755
  end
end
