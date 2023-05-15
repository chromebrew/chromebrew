require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  @_ver = '1.2.0'
  version "#{@_ver}-1"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/hokaccha/nodebrew/archive/v#{@_ver}.tar.gz"
  source_sha256 '6d72e39c8acc5b22f4fc7a1734cd3bb8d00b61119ab7fea6cde376810ff2005e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nodebrew/1.2.0-1_armv7l/nodebrew-1.2.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nodebrew/1.2.0-1_armv7l/nodebrew-1.2.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nodebrew/1.2.0-1_i686/nodebrew-1.2.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nodebrew/1.2.0-1_x86_64/nodebrew-1.2.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2d66f5d8c02b4eb1709837d8a1271988441507f58ee3e05a4db99861cb01f229',
     armv7l: '2d66f5d8c02b4eb1709837d8a1271988441507f58ee3e05a4db99861cb01f229',
       i686: '1b9e9e93a6c8cdffbb47bc09ac84b8ca2e40536c903f79be55927a8a694aefd3',
     x86_64: '1756ea6eb396fd0e448b7dfbf9c7d37e95fb22b616c03ffc833a219777a275f9'
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
    # Download fails unless this directory is created.
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.nodebrew/src"
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
    @env = <<~NODEBREWENVEOF
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
    return unless Dir.exist? "#{CREW_PREFIX}/share/nodebrew"

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
