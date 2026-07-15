require 'buildsystems/cmake'

class Fish < CMake
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'https://fishshell.com/'
  version '4.8.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'baa517896385de88c1fe2056ef30ce1da9db16c5e1be86174c67ff283793fe64',
     armv7l: 'baa517896385de88c1fe2056ef30ce1da9db16c5e1be86174c67ff283793fe64',
       i686: '816eb60c0073e8eab3a22f4c14b88a570e41c220bbcd890903bd6bcd0db927de',
     x86_64: '5fc988993b9b12499939e31c077ee613943f5d7973df2867d1e4a3175f9c28b7'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'pcre2' => :executable

  cmake_options "-DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncurses"

  def self.postinstall
    ExitMessage.add <<~EOT1.lightblue
      To run fish, type `fish` in your terminal.
      Even if you are already in fish, you should now start a new fish session.

      To use fish as your login shell:
      * add the line '#{CREW_PREFIX}/bin/fish' to the file '#{CREW_PREFIX}/etc/shells':
      echo '#{CREW_PREFIX}/bin/fish' | tee -a #{CREW_PREFIX}/etc/shells > /dev/null
      * run 'chsh -s #{CREW_PREFIX}/bin/fish'

      To set your colors, run `fish_config`
      To scan your man pages for completions, run `fish_update_completions`
      To accept autosuggestions (in grey) as you type, hit `ctrl-F` or right arrow key.

      Have fun! <><
    EOT1
  end
end
