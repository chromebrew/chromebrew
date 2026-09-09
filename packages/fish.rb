require 'buildsystems/cmake'

class Fish < CMake
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'https://fishshell.com/'
  version '4.9.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1688bc1f080140a15dfb094b8eb6706e68747b0890681413d0bcb5c1a642e33',
     armv7l: 'f1688bc1f080140a15dfb094b8eb6706e68747b0890681413d0bcb5c1a642e33',
       i686: '55f0150cb87520064bc1b8b3bf97af6b9c26504436766ac2674bc368ea64abc7',
     x86_64: '0dcc051c253dc780207730dc323c76410eaafc729dcacfac8ce7651088daab6a'
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
