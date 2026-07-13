require 'package'

class Glab < Package
  description 'A GitLab CLI tool bringing GitLab to your command line'
  homepage 'https://gitlab.com/gitlab-org/cli'
  version '1.107.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
     armv7l: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_armv6.tar.gz",
       i686: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_386.tar.gz",
     x86_64: "https://gitlab.com/gitlab-org/cli/-/releases/v#{version}/downloads/glab_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '3761d584b86a50e56b4fd159dbb29ec6eb8acbbaf4f0768a19ed1a8a24c2fd52',
     armv7l: '3761d584b86a50e56b4fd159dbb29ec6eb8acbbaf4f0768a19ed1a8a24c2fd52',
       i686: '7dba0206674beca76e991b77ae7aa6fed30f8d3df1d36728243adcbc2e9b4466',
     x86_64: 'eb42f56eb1a789cf4f22aa5960ff0ef60cf1e7fc1295327501f9f59030d5ae2c'
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
