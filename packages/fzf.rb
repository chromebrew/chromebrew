require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.61.1'
  license 'MIT and BSD-with-disclosure'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '6472fdc1ede0156755badfefa2d3be487148189fe79feaeb175e9fae7eb96e01',
     armv7l: '6472fdc1ede0156755badfefa2d3be487148189fe79feaeb175e9fae7eb96e01',
     x86_64: 'f728b94bbbf7008602581fc07ea00de5dccf55a2cb2bf9fd9a35f1071b3b9f6c'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
