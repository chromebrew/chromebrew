require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  version '0.0.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_profile_base/0.0.1-pre6_armv7l/crew_profile_base-0.0.1-pre6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_profile_base/0.0.1-pre6_armv7l/crew_profile_base-0.0.1-pre6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_profile_base/0.0.1-pre6_i686/crew_profile_base-0.0.1-pre6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/crew_profile_base/0.0.1-pre6_x86_64/crew_profile_base-0.0.1-pre6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '042a8b84951511fbc017b2418b8c1eb92d40cba81e1e4e00c0e1d903ad2af032',
     armv7l: '042a8b84951511fbc017b2418b8c1eb92d40cba81e1e4e00c0e1d903ad2af032',
       i686: 'c354988e590dbe7cb5d40f683c2a6ec8aecaf497d5844f75bc7a211690ab4406',
     x86_64: '6ecb01e0cbee6a2bee0b8d86b5fc6d86db92aacf9e2ef2ff892b3d846d5bb4dc'
  })

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
      FileUtils.rm './src/env.d/00-locale' if File.exist? "#{CREW_PREFIX}/etc/env.d/00-locale"
      FileUtils.rm './src/env.d/01-editor' if File.exist? "#{CREW_PREFIX}/etc/env.d/01-editor"
      FileUtils.rm './src/env.d/02-pager' if File.exist? "#{CREW_PREFIX}/etc/env.d/02-pager"

      FileUtils.mkdir_p "#{CREW_PREFIX}/etc/"
      FileUtils.cp_r Dir.glob('./src/*'), "#{CREW_PREFIX}/etc/"

      # Remove stale files from the last install
      FileUtils.rm "#{HOME}/.bashrc.bak" if File.exist? "#{HOME}/.bashrc.bak"
      FileUtils.rm "#{HOME}/.zshrc.bak" if File.exist? "#{HOME}/.zshrc.bak"

      # Don't overwrite a custom shell rc
      @_str = "source #{CREW_PREFIX}/etc/profile"
      FileUtils.touch "#{HOME}/.bashrc" unless File.exist? "#{HOME}/.bashrc"
      FileUtils.touch "#{HOME}/.zshrc" unless File.exist? "#{HOME}/.zshrc"
      FileUtils.mv "#{HOME}/.bashrc", "#{HOME}/.bashrc.bak" if `grep -c '#{@_str}' #{HOME}/.bashrc`.to_i.zero?
      FileUtils.mv "#{HOME}/.zshrc", "#{HOME}/.zshrc.bak" if `grep -c '#{@_str}' #{HOME}/.zshrc`.to_i.zero?

      # Write our rc files
      @crew_rcfile = <<~CREW_PROFILE_EOF
                # DO NOT DELETE THIS LINE
                # See #{CREW_PREFIX}/etc/profile for further details
                source #{CREW_PREFIX}/etc/profile

                # Put your stuff under this comment
      CREW_PROFILE_EOF
      # Must write directly to HOME and not CREW_DEST_HOME to prevent chromebrew from removing ~/.bashrc during reinstall
      IO.write("#{HOME}/.bashrc", @crew_rcfile) unless File.exist? "#{HOME}/.bashrc"
      IO.write("#{HOME}/.zshrc", @crew_rcfile) unless File.exist? "#{HOME}/.zshrc"

      # Don't overwrite a custom shell rc part 2
      system "cat #{HOME}/.bashrc.bak >> #{HOME}/.bashrc" if File.exist? "#{HOME}/.bashrc.bak"
      system "cat #{HOME}/.zshrc.bak >> #{HOME}/.zshrc" if File.exist? "#{HOME}/.zshrc.bak"

      puts
      puts 'IT IS IMPERATIVE TO THE FUNCTION OF CHROMEBREW FOR'.lightblue
      puts "#{HOME}/.bashrc to contain the line 'source #{CREW_PREFIX}/etc/profile'.".lightblue
      puts 'This should have happened automatically.'.lightblue
      puts "If the line doesn't exist, add it now and report a bug at https://github.com/chromebrew/crew-profile-base/issues.".lightblue
      puts
    end
  end
end
