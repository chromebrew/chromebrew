require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.132.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'bd766fad44eb0f7251a758b3ae8659159ed24dac7f9e8b2eb9d10f15acd6b490',
     armv7l: 'bd766fad44eb0f7251a758b3ae8659159ed24dac7f9e8b2eb9d10f15acd6b490',
       i686: '47ac105a5aeaf93c74aed15a6ca0c37b8e06fd9d585491e6edc85214e0a16dbf',
     x86_64: '24d654844cae9f8f24193219ad481a4ebf01c1dc7340ea4107ee2bedd93f9e53'
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
