require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.22.1'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.22.1/gh_2.22.1_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.22.1/gh_2.22.1_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.22.1/gh_2.22.1_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.22.1/gh_2.22.1_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '45f39108cd0d08a1f6d0bb3d26ecad40d515001bc10fc1e22396c650d316520d',
     armv7l: '45f39108cd0d08a1f6d0bb3d26ecad40d515001bc10fc1e22396c650d316520d',
       i686: '81c2e6b7ab316460bb5d72ab5605fda5e481b3a6162d0425dd1837ebee3077c6',
     x86_64: '76f7e18bdad5ddfdfcab40fce86c8d6f9fb27f9d29c1287cdf71e0d6b45ba84b'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX.to_s
  end
end
