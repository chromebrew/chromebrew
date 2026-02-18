require 'buildsystems/cmake'

class Fish < CMake
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'https://fishshell.com/'
  version '4.5.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9e7ccc4cb1112f9a072e0f197ca1102a58c70a4948daa5621d0b9c78a18354d9',
     armv7l: '9e7ccc4cb1112f9a072e0f197ca1102a58c70a4948daa5621d0b9c78a18354d9',
       i686: '16e2bc3268102d2ba4fd5d1274da223bf5a99180fa6d55b582db31f06e5fd6eb',
     x86_64: '63a98e736003d44d6517455d87bb165da4c8d0afa5bdffda05769a14f3079a46'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'pcre2' # R

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
