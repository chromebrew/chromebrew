require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.68.0'
  license 'MIT and BSD-with-disclosure'
  compatibility 'all'
  source_url 'https://github.com/junegunn/fzf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '135739dc22d8c6a621ccfeb57d76cdacfe437d98a4932a76d41437df01ed2481',
     armv7l: '135739dc22d8c6a621ccfeb57d76cdacfe437d98a4932a76d41437df01ed2481',
       i686: '508e3e147c49cf56ab86e6399253de04dab66051eb4674621eec2b0b58e10af9',
     x86_64: '9eec396e22ab6a047ee7269c2f8f448aeb6804edd559a893aa148febd6fcacc8'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build
  depends_on 'tmux' # R - Needed for tmux integration

  print_source_bashrc

  def self.build
    File.write '10-fzf', <<~EOF
      # Set up fzf key bindings and fuzzy completion
      eval "$(fzf --bash)"
    EOF
    system 'go build -o bin/fzf'
  end

  def self.install
    FileUtils.install 'bin/fzf', "#{CREW_DEST_PREFIX}/bin/fzf", mode: 0o755
    FileUtils.install 'bin/fzf-tmux', "#{CREW_DEST_PREFIX}/bin/fzf-tmux", mode: 0o755
    FileUtils.install 'man/man1/fzf.1', "#{CREW_DEST_MAN_PREFIX}/man1/fzf.1", mode: 0o644
    FileUtils.install 'man/man1/fzf-tmux.1', "#{CREW_DEST_MAN_PREFIX}/man1/fzf-tmux.1", mode: 0o644
    FileUtils.install '10-fzf', "#{CREW_DEST_PREFIX}/etc/bash.d/10-fzf", mode: 0o644
  end
end
