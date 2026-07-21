require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.74.1'
  license 'MIT and BSD-with-disclosure'
  compatibility 'all'
  source_url 'https://github.com/junegunn/fzf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a97f1008ee5cb1f66578f46281e20bc08974ff93919706ab51c83e389899018d',
     armv7l: 'a97f1008ee5cb1f66578f46281e20bc08974ff93919706ab51c83e389899018d',
       i686: '9bc0b119091bba2603fecdc18215ba09e68b2d044f73e9d1c198b0280e66c888',
     x86_64: '16c075b9750fa245a91a6c1fc5099822456aa9ff686a39758c3995f15e359ce1'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
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
