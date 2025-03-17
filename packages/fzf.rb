require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.60.3'
  license 'MIT and BSD-with-disclosure'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '91c417f7625370ffdf9e2b198fb395dc84da7978cc1d9c6f6dad91197a54b60d',
     armv7l: '91c417f7625370ffdf9e2b198fb395dc84da7978cc1d9c6f6dad91197a54b60d',
     x86_64: '2937a4f10b0f80e0c974d9459df3bc049b068a97212b0d253c36c9da5920b521'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
