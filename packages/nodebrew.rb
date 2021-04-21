require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  @_ver = '1.0.1'
  version "#{@_ver}-2"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/hokaccha/nodebrew/archive/v#{@_ver}.tar.gz"
  source_sha256 'c34e7186d4fd493c5417ad5563ad39fd493a42695bd9a7758c3df10380e43399'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/nodebrew-1.0.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/nodebrew-1.0.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/nodebrew-1.0.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/nodebrew-1.0.1-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ea1dc71bbdb987b742474128b4836e643beec4abcd48c7a2bc695092f8b19d39',
     armv7l: 'ea1dc71bbdb987b742474128b4836e643beec4abcd48c7a2bc695092f8b19d39',
       i686: 'b07ef1989b2f09f340eee6901d00652639f6e4dfb7c47d958bfebfe267fd5285',
     x86_64: 'f564dade9448caa2763eddb292060e0dab2c17740f0b898c71432dc8e2ce3d48'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/nodebrew/default"
    system "NODEBREW_ROOT=#{CREW_DEST_PREFIX}/share/nodebrew perl nodebrew setup > /dev/null"
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/nodebrew", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/node", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/npm", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/npx", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/node", "#{CREW_DEST_PREFIX}/bin/nodejs"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew", "#{CREW_DEST_HOME}/.nodebrew"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/nodebrew", "#{HOME}/.nodebrew"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @bashd = <<~NODEBREWCOMPLETIONEOF
      # nodebrew bash completion
      source #{CREW_PREFIX}/share/nodebrew/completions/bash/nodebrew-completion
    NODEBREWCOMPLETIONEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/nodebrew", @bashd)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~'NODEBREWENVEOF'
      # nodebrew configuration
      export PATH="$PATH:$HOME/.nodebrew/current/bin"
    NODEBREWENVEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/nodebrew", @env)
  end

  def self.postinstall
    FileUtils.ln_sf "#{CREW_PREFIX}/share/nodebrew/default", "#{CREW_PREFIX}/share/nodebrew/current"
    puts
    puts 'To install the latest node, execute:'.lightblue
    puts 'nodebrew install-binary latest'.lightblue
    puts 'nodebrew use latest'.lightblue
    puts
  end

  def self.remove
    if Dir.exist? "#{CREW_PREFIX}/share/nodebrew"
      puts
      print "Would you like to remove #{CREW_PREFIX}/share/nodebrew? [y/N] "
      response = $stdin.getc
      case response
      when 'y', 'Y'
        FileUtils.rm_rf "#{CREW_PREFIX}/share/nodebrew"
        puts "#{CREW_PREFIX}/share/nodebrew removed.".lightred
      else
        puts "#{CREW_PREFIX}/share/nodebrew saved.".lightgreen
      end
      puts
    end
  end
end
