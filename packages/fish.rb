require 'package'

class Fish < Package
  description 'fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family.'
  homepage 'http://fishshell.com/'
  version '3.1.2'
  compatibility 'all'
  source_url 'https://github.com/fish-shell/fish-shell/releases/download/3.1.2/fish-3.1.2.tar.gz'
  source_sha256 'd5b927203b5ca95da16f514969e2a91a537b2f75bec9b21a584c4cd1c7aa74ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fish-3.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fish-3.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fish-3.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fish-3.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1247991fb1785e9c5eede833c1f2dcc7c38c738b6d7a87a06fcdb752d9a246b8',
     armv7l: '1247991fb1785e9c5eede833c1f2dcc7c38c738b6d7a87a06fcdb752d9a246b8',
       i686: '3f5430b6e269025d8ed31324916b3eee89121fc3dab5cfd47486d41838efa764',
     x86_64: '12b58c3c7a4bdfb45b4286a98fd5254ef4641489c3b582c7fcbf2e571fe31839',
  })

  depends_on 'pcre2'
  depends_on 'termcap'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DBUILD_DOCS=OFF',
             '-DBUILD_SHARED_LIBS=ON',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_CXX_FLAGS='-lncurses -ltermcap -I#{CREW_PREFIX}/include/ncurses'",
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.postinstall
    puts
    puts "To run fish, type `fish` in your terminal.".lightblue
    puts "Even if you are already in fish, you should now start a new fish session.".lightblue
    puts
    puts "To use fish as your login shell:".lightblue
    puts "* add the line '#{CREW_PREFIX}/bin/fish' to the file '#{CREW_PREFIX}/etc/shells':".lightblue
    puts "echo '#{CREW_PREFIX}/bin/fish' | tee -a #{CREW_PREFIX}/etc/shells > /dev/null".lightblue
    puts "* run 'chsh -s #{CREW_PREFIX}/bin/fish'".lightblue
    puts
    puts "If you have SELinux enabled, you may need to manually update the security policy:".lightblue
    puts "* use the command 'chcon -t shell_exec_t #{CREW_PREFIX}/bin/fish'".lightblue
    puts
    puts "To set your colors, run `fish_config`".lightblue
    puts "To scan your man pages for completions, run `fish_update_completions`".lightblue
    puts "To accept autosuggestions (in grey) as you type, hit `ctrl-F` or right arrow key.".lightblue
    puts
    puts "Have fun! <><".lightblue
    puts
  end
end
