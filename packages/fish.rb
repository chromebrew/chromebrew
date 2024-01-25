require 'buildsystems/cmake'

class Fish < CMake
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'http://fishshell.com/'
  version '3.6.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2bee4bba2f6c8095365ad968100bfcbdc3848e818d030f5cad834042e309c9de',
     armv7l: '2bee4bba2f6c8095365ad968100bfcbdc3848e818d030f5cad834042e309c9de',
       i686: 'b58e4541bfc8666db7baad74283729cd91479d3db81897a58da83b6ec603f2dc',
     x86_64: '70bbe3d5df4e138969c67a03db41b9097b644a5db7d7d7765ec6c2bf9a56efe2'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'llvm17_dev' => :build
  depends_on 'ncurses' # R
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

      If you have SELinux enabled, you may need to manually update the security policy:
      * use the command 'chcon -t shell_exec_t #{CREW_PREFIX}/bin/fish'

      To set your colors, run `fish_config`
      To scan your man pages for completions, run `fish_update_completions`
      To accept autosuggestions (in grey) as you type, hit `ctrl-F` or right arrow key.

      Have fun! <><
    EOT1
  end
end
