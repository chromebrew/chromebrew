require 'package'

class Github_cli < Package
  description 'Official Github CLI tool'
  homepage 'https://cli.github.com/'
  version '2.55.0'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
     armv7l: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_armv6.tar.gz",
       i686: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_386.tar.gz",
     x86_64: "https://github.com/cli/cli/releases/download/v#{version}/gh_#{version}_linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '7a7f496e4e952867582fcbbd959b8a7cbbfdf715625e396e03f3f2fbd97f26da',
     armv7l: '7a7f496e4e952867582fcbbd959b8a7cbbfdf715625e396e03f3f2fbd97f26da',
       i686: 'cbb7537847a35da76c588f8376b8c6e44ba2e16cd6d7133144b1b494ee80027f',
     x86_64: '49700b3fedb5bfcbef696fe9f1f69091ceb9caf2d40bd872b5028c451efc52bc'
  })

  no_compile_needed
  no_shrink
  no_strip # ./usr/local/bin/gh: 1: ./usr/local/bin/gh: Syntax error: redirection unexpected (expecting ")")

  def self.install
    FileUtils.install 'bin/gh', "#{CREW_DEST_PREFIX}/bin/gh", mode: 0o755
    FileUtils.mv 'share', CREW_DEST_PREFIX
  end
end
