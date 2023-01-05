require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  @_ver = '1.2.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/hokaccha/nodebrew/archive/v#{@_ver}.tar.gz"
  source_sha256 '6d72e39c8acc5b22f4fc7a1734cd3bb8d00b61119ab7fea6cde376810ff2005e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nodebrew/1.2.0_armv7l/nodebrew-1.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nodebrew/1.2.0_armv7l/nodebrew-1.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nodebrew/1.2.0_i686/nodebrew-1.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nodebrew/1.2.0_x86_64/nodebrew-1.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '319000f56a7e608647a19ed95fa7a555a815cf3b64990cf11ceddd3d5ba658e9',
     armv7l: '319000f56a7e608647a19ed95fa7a555a815cf3b64990cf11ceddd3d5ba658e9',
       i686: 'f5cfdff134b421478106612cc2c4ee2d6a7135fac4cf0bec06a7d10653903572',
     x86_64: '0bb4d2d805938635bff351f4154c95b177ddc87a21d7a86ad63fd49a2524b34a'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/nodebrew/default"
    system "NODEBREW_ROOT=#{CREW_DEST_PREFIX}/share/nodebrew perl nodebrew setup > /dev/null"
    case ARCH
    when 'aarch64', 'armv7l'
      # Handle being in a container on an aarch64 machine which exposes armv8l support.
      system "sed -i 's@m/armv7l/@m/armv[7,8]l/@g' #{CREW_DEST_PREFIX}/share/nodebrew/nodebrew"
    when 'i686'
      # Handle x86 binaries no longer showing up on the official build server.
      system "sed -i 's,nodejs.org/dist,unofficial-builds.nodejs.org/download/release,g' #{CREW_DEST_PREFIX}/share/nodebrew/nodebrew"
    end
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
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/nodebrew", @bashd)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~'NODEBREWENVEOF'
      # nodebrew configuration
      export PATH="$PATH:$HOME/.nodebrew/current/bin"
    NODEBREWENVEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/nodebrew", @env)
  end

  def self.postinstall
    FileUtils.ln_sf "#{CREW_PREFIX}/share/nodebrew/default", "#{CREW_PREFIX}/share/nodebrew/current"
    puts
    if ARCH == 'i686'
      puts 'FYI: v17.9.1 is the last version compatible with i686.'.orange
      puts 'To install the latest node, execute:'.lightblue
      puts 'nodebrew install-binary v17.9.1'.lightblue
    elsif LIBC_VERSION.to_f <= 2.27
      puts 'FYI: v16.18.1 is the last version compatible with GLIBC 2.27'.orange
      puts 'To install the latest node, execute:'.lightblue
      puts 'nodebrew install-binary v16.18.1'.lightblue
    else
      puts 'To install the latest node, execute:'.lightblue
      puts 'nodebrew install-binary latest'.lightblue
    end
    puts 'nodebrew use latest'.lightblue
    puts
  end

  def self.remove
    if Dir.exist? "#{CREW_PREFIX}/share/nodebrew"
      puts
      print "Would you like to remove #{CREW_PREFIX}/share/nodebrew? [y/N] "
      response = $stdin.gets.chomp.downcase
      case response
      when 'y', 'yes'
        FileUtils.rm_rf "#{CREW_PREFIX}/share/nodebrew"
        puts "#{CREW_PREFIX}/share/nodebrew removed.".lightred
      else
        puts "#{CREW_PREFIX}/share/nodebrew saved.".lightgreen
      end
      puts
    end
  end
end
