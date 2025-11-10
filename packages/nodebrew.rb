require 'package'

class Nodebrew < Package
  description 'Node.js version manager'
  homepage 'https://github.com/hokaccha/nodebrew'
  version '1.2.0-4'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/hokaccha/nodebrew/archive/v#{version.split('-').first}.tar.gz"
  source_sha256 '6d72e39c8acc5b22f4fc7a1734cd3bb8d00b61119ab7fea6cde376810ff2005e'

  no_compile_needed
  print_source_bashrc

  def self.patch
    patch = [
      [
        'https://patch-diff.githubusercontent.com/raw/hokaccha/nodebrew/pull/75.patch',
        '80f3e43cb92cdf1ea71db675c34987fcd059fc3af3d45094573c3a7d33759213'
      ]
    ]
    ConvenienceFunctions.patch(patch)
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
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/nodebrew", <<~NODEBREWCOMPLETIONEOF
      # nodebrew bash completion
      source #{CREW_PREFIX}/share/nodebrew/completions/bash/nodebrew-completion
    NODEBREWCOMPLETIONEOF

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/nodebrew", <<~NODEBREWENVEOF
      NODEBREW_ROOT=#{CREW_PREFIX}/share/nodebrew
      # nodebrew configuration
      PATH="$PATH:#{CREW_PREFIX}/share/nodebrew/current/bin"
    NODEBREWENVEOF
  end

  def self.postinstall
    puts
    if ARCH == 'i686'
      puts 'FYI: v21.x is the last version compatible with i686.'.orange
      system 'source ~/.bashrc; nodebrew install 21', exception: false
    elsif LIBC_VERSION.to_f <= 2.27
      puts 'FYI: v16.x is the last version compatible with GLIBC 2.27.'.orange
      system 'source ~/.bashrc; nodebrew install 16', exception: false
    else
      system 'source ~/.bashrc; nodebrew install latest', exception: false
    end
    system 'source ~/.bashrc; nodebrew use latest', exception: false
    puts
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.npm")
    Package.agree_to_remove("#{CREW_PREFIX}/share/nodebrew")
  end
end
