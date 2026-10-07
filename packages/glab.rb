require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.121.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '6638790d63f2a7ac077445faa00dadb4f272102831eb1aad88896f5e09d33785',
     armv7l: '6638790d63f2a7ac077445faa00dadb4f272102831eb1aad88896f5e09d33785',
       i686: '844bc9fd91a439c31b0f0a413afa8451ef06abb0b6efde236e6897f73016d5a0',
     x86_64: '52266084418da237222a2146a7fd82b0ac9be263133efeb296fe3b12b6bfd48f'
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
