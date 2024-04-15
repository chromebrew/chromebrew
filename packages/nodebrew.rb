require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  @_ver = '1.2.0'
  version "#{@_ver}-3"
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/hokaccha/nodebrew/archive/v#{@_ver}.tar.gz"
  source_sha256 '6d72e39c8acc5b22f4fc7a1734cd3bb8d00b61119ab7fea6cde376810ff2005e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3380b54a63dcb41668a5e2d3342052278dc3c9356b8436b29bc791b1083b79cc',
     armv7l: '3380b54a63dcb41668a5e2d3342052278dc3c9356b8436b29bc791b1083b79cc',
       i686: '62b3e1fa67d1bd03e43b3db86acb63456fb49c60acdeddd11ce9bcd5d4f66e41',
     x86_64: '2845cc94c9d7507dff3270640178852e1552f3523bbb13634cc836b430cb03db'
  })

  print_source_bashrc

  def self.patch
    downloader 'https://patch-diff.githubusercontent.com/raw/hokaccha/nodebrew/pull/75.patch', '80f3e43cb92cdf1ea71db675c34987fcd059fc3af3d45094573c3a7d33759213'
    system 'patch -p1 -i 75.patch'
  end

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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/nodebrew/current"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/default", "#{CREW_DEST_PREFIX}/share/nodebrew/current"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/nodebrew", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/node", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/npm", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/npx", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/nodebrew/current/bin/node", "#{CREW_DEST_PREFIX}/bin/nodejs"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @bashd = <<~NODEBREWCOMPLETIONEOF
      # nodebrew bash completion
      source #{CREW_PREFIX}/share/nodebrew/completions/bash/nodebrew-completion
    NODEBREWCOMPLETIONEOF
    File.write("#{CREW_DEST_PREFIX}/etc/bash.d/nodebrew", @bashd)

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @env = <<~NODEBREWENVEOF
      NODEBREW_ROOT=#{CREW_PREFIX}/share/nodebrew
      # nodebrew configuration
      PATH="$PATH:#{CREW_PREFIX}/share/nodebrew/current/bin"
    NODEBREWENVEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/nodebrew", @env)
  end

  def self.postinstall
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
