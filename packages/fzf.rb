require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.60.1'
  license 'MIT and BSD-with-disclosure'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/v#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '0f01c2455da9e5af1e5f571af67fc02c782580ba4827e207ece801825b001e54',
     armv7l: '0f01c2455da9e5af1e5f571af67fc02c782580ba4827e207ece801825b001e54',
     x86_64: 'ff53fbfa60ca927c022394fdb5599f9ab3cc98bdd78f60b5cc1aec497ea5b84e'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
