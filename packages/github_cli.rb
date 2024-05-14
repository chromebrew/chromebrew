require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.49.2'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/cli/cli/releases/download/v2.49.2/gh_2.49.2_linux_armv6.tar.gz',
     armv7l: 'https://github.com/cli/cli/releases/download/v2.49.2/gh_2.49.2_linux_armv6.tar.gz',
       i686: 'https://github.com/cli/cli/releases/download/v2.49.2/gh_2.49.2_linux_386.tar.gz',
     x86_64: 'https://github.com/cli/cli/releases/download/v2.49.2/gh_2.49.2_linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '6059d3abe06451d462aad55c36d572f6da81e3aba57b012953b50dceddda2182',
     armv7l: '6059d3abe06451d462aad55c36d572f6da81e3aba57b012953b50dceddda2182',
       i686: '48c29f686ee1be279ee42be78c0d69e22657403279f036909825419037155685',
     x86_64: 'd84b514b64b802c703009453c935068384162253d1288d947f9488b98fb00fbc'
  })

  no_compile_needed
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
