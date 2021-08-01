require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  version '0.0.2'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'SKIP'


  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/profile.d"
  end

  def self.postinstall
    # Extract as module in postinstall to avoid creating package binaries.
    # Turn off git warnings.
    system 'git config --global advice.detachedHead false'
    system 'git config --global init.defaultBranch main'
    @git_dir = 'crew_profile_base_git'
    @git_hash = version
    @git_url = 'https://github.com/chromebrew/crew-profile-base'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'

      # Don't overwrite custom changes
      FileUtils.rm './src/env.d/99-custom' if File.exist? "#{CREW_PREFIX}/etc/env.d/99-custom"
      FileUtils.rm './src/profile.d/99-custom' if File.exist? "#{CREW_PREFIX}/etc/profile.d/99-custom"
      # Custom changes should only go in the above two files.
      # FileUtils.rm './src/env.d/00-locale' if File.exist? "#{CREW_PREFIX}/etc/env.d/00-locale"
      # FileUtils.rm './src/env.d/01-editor' if File.exist? "#{CREW_PREFIX}/etc/env.d/01-editor"
      # FileUtils.rm './src/env.d/02-pager' if File.exist? "#{CREW_PREFIX}/etc/env.d/02-pager"

      FileUtils.mkdir_p "#{CREW_PREFIX}/etc/"
      FileUtils.cp_r Dir.glob('./src/*'), "#{CREW_PREFIX}/etc/"

      # Remove stale files from the last install
      FileUtils.rm "#{HOME}/.bashrc.bak" if File.exist? "#{HOME}/.bashrc.bak"
      FileUtils.rm "#{HOME}/.zshrc.bak" if File.exist? "#{HOME}/.zshrc.bak"

      # dbus file moved to dbus package, so remove it.
      FileUtils.rm_f './src/env.d/env.d/03-dbus'
      FileUtils.rm_f "#{CREW_PREFIX}/etc/env.d/03-dbus"

      # Don't overwrite a custom shell rc
      @_str = "source #{CREW_PREFIX}/etc/profile"

      # Write our rc files
      @crew_rcfile = <<~CREW_PROFILE_EOF
        # DO NOT DELETE THIS LINE
        # See #{CREW_PREFIX}/etc/profile for further details
        source #{CREW_PREFIX}/etc/profile

        # Put your stuff under this comment

      CREW_PROFILE_EOF
      # Must write directly to HOME and not CREW_DEST_HOME to prevent chromebrew from removing ~/.bashrc during reinstall
      if File.exist? "#{HOME}/.bashrc"
        if `grep -c "#{@_str}" #{HOME}/.bashrc`.to_i.zero?
          old_bashrc = IO.read "#{HOME}/.bashrc"
          IO.write "#{HOME}/.bashrc", @crew_rcfile + old_bashrc
        end
      else
        IO.write("#{HOME}/.bashrc", @crew_rcfile)
      end
      if File.exist? "#{HOME}/.zshrc"
        if `grep -c "#{@_str}" #{HOME}/.zshrc`.to_i.zero?
          old_zshrc = IO.read "#{HOME}/.zshrc"
          IO.write "#{HOME}/.zshrc", @crew_rcfile + old_zshrc
        end
      else
        IO.write("#{HOME}/.zshrc", @crew_rcfile)
      end
    end
  end
end
