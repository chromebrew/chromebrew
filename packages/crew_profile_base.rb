require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  version '0.0.1-pre4'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-profile-base/archive/refs/tags/0.0.1-pre4.tar.gz'
  source_sha256 '3a8a8eb26cd9b314b728e532ec220ace033bf2e3d1c4517fd2d393ce6e586c4d'

  # This package shouldn't have binaries.
  binary_url ({

  })
  binary_sha256 ({

  })

  def self.preinstall
    # Don't overwrite custom changes
    FileUtils.rm "./src/env.d/99-custom" if File.exists? "#{CREW_PREFIX}/etc/env.d/99-custom"
    FileUtils.rm "./src/profile.d/99-custom" if File.exists? "#{CREW_PREFIX}/etc/profile.d/99-custom"
    FileUtils.rm "./src/env.d/00-locale" if File.exists? "#{CREW_PREFIX}/etc/env.d/00-locale"
    FileUtils.rm "./src/env.d/01-editor" if File.exists? "#{CREW_PREFIX}/etc/env.d/01-editor"
    FileUtils.rm "./src/env.d/02-pager" if File.exists? "#{CREW_PREFIX}/etc/env.d/02-pager"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.cp_r Dir.glob('./src/*'), "#{CREW_DEST_PREFIX}/etc/"
  end

  def self.postinstall
    # Remove stale files from the last install
    FileUtils.rm "#{HOME}/.bashrc.bak" if File.exists? "#{HOME}/.bashrc.bak"
    FileUtils.rm "#{HOME}/.zshrc.bak" if File.exists? "#{HOME}/.zshrc.bak"

    # Don't overwrite a custom shell rc
    @_str = "source #{CREW_PREFIX}/etc/profile"
    FileUtils.touch "#{HOME}/.bashrc" unless File.exists? "#{HOME}/.bashrc"
    FileUtils.touch "#{HOME}/.zshrc" unless File.exists? "#{HOME}/.zshrc"
    FileUtils.mv "#{HOME}/.bashrc", "#{HOME}/.bashrc.bak" if `grep -c '#{@_str}' #{HOME}/.bashrc`.to_i.zero?
    FileUtils.mv "#{HOME}/.zshrc", "#{HOME}/.zshrc.bak" if `grep -c '#{@_str}' #{HOME}/.zshrc`.to_i.zero?

    # Write our rc files
    @rcfile = <<~EOF
      # DO NOT DELETE THIS LINE
      # See #{CREW_PREFIX}/etc/profile for further details
      source #{CREW_PREFIX}/etc/profile

      # Put your stuff under this comment
    EOF
    # Must write directly to HOME and not CREW_DEST_HOME to prevent chromebrew from removing ~/.bashrc during reinstall
    IO.write("#{HOME}/.bashrc", @rcfile) unless File.exists? "#{HOME}/.bashrc"
    IO.write("#{HOME}/.zshrc", @rcfile) unless File.exists? "#{HOME}/.zshrc"

    # Don't overwrite a custom shell rc part 2
    system "cat #{HOME}/.bashrc.bak >> #{HOME}/.bashrc" if File.exists? "#{HOME}/.bashrc.bak"
    system "cat #{HOME}/.zshrc.bak >> #{HOME}/.zshrc" if File.exists? "#{HOME}/.zshrc.bak"

    puts
    puts "IT IS IMPERATIVE TO THE FUNCTION OF CHROMEBREW FOR".lightblue
    puts "#{HOME}/.bashrc to contain the line 'source #{CREW_PREFIX}/etc/profile'.".lightblue
    puts "This should have happened automatically.".lightblue
    puts "If the line doesn't exist, add it now and report a bug at https://github.com/chromebrew/crew-profile-base/issues.".lightblue
    puts
  end
end
