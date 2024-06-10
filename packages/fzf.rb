require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.53.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: "https://github.com/junegunn/fzf/releases/download/#{version}/fzf-#{version}-linux_armv7.tar.gz",
     armv7l: "https://github.com/junegunn/fzf/releases/download/#{version}/fzf-#{version}-linux_armv7.tar.gz",
     x86_64: "https://github.com/junegunn/fzf/releases/download/#{version}/fzf-#{version}-linux_amd64.tar.gz"
  })
  source_sha256({
    aarch64: '71b986c3a57144ac902b13231f33345c111ffd6689b884b3af6f2f609e3d5013',
     armv7l: '71b986c3a57144ac902b13231f33345c111ffd6689b884b3af6f2f609e3d5013',
     x86_64: 'af2663c3309967dc191d21537e53c2e9f8a37f490a32456b9498a006f05e3796'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
