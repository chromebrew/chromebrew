require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.56.3'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '26408ce7ec311518dba6d8dd326bcf099bf8d97d21d40138cf303dab9c6f4f3f',
     armv7l: '26408ce7ec311518dba6d8dd326bcf099bf8d97d21d40138cf303dab9c6f4f3f',
     x86_64: '78e96a88cecfbdb3ff65df89cc47c02573407aee0edd08c87e18a8033d498fef'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
