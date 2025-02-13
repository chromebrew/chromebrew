require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.60.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '9d83faf85b27f2d7da8602024cb65a5d3218b7e36a56b036411d086f815c86c7',
     armv7l: '9d83faf85b27f2d7da8602024cb65a5d3218b7e36a56b036411d086f815c86c7',
     x86_64: 'c7af0376077054767ed88637f72cab78c563e2b44c4e0101ebfd84fffdbcd339'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
