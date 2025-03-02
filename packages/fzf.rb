require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.60.2'
  license 'MIT and BSD-with-disclosure'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '02899013d30d7a397a4dec335d86c63eb8443c6f032ab8272c7c0e5a4aad975d',
     armv7l: '02899013d30d7a397a4dec335d86c63eb8443c6f032ab8272c7c0e5a4aad975d',
     x86_64: 'f459d9c0676edfcd4a717efc48ea7768d395d5745872d34ae338452017381839'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
