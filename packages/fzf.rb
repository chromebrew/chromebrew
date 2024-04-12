require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.49.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/junegunn/fzf/releases/download/0.49.0/fzf-0.49.0-linux_armv7.tar.gz',
     armv7l: 'https://github.com/junegunn/fzf/releases/download/0.49.0/fzf-0.49.0-linux_armv7.tar.gz',
     x86_64: 'https://github.com/junegunn/fzf/releases/download/0.49.0/fzf-0.49.0-linux_amd64.tar.gz'
  })
  source_sha256({
    aarch64: '6cc088b6cf7b7a7ca988b5f4799dc624a31ca542a2d71866c6e3397425481aa3',
     armv7l: '6cc088b6cf7b7a7ca988b5f4799dc624a31ca542a2d71866c6e3397425481aa3',
     x86_64: '0c8df3ed2633b8d14643b0c47d4fae4bbe5987cdfc34eb1db438b2d04db3c041'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
  end
end
