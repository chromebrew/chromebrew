require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  version '0.0.4'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-profile-base.git'
  git_hashtag version

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/profile.d"

    # dbus file moved to dbus package, so remove it.
    FileUtils.rm_f './src/env.d/env.d/03-dbus'
    FileUtils.rm_f "#{CREW_PREFIX}/etc/env.d/03-dbus"

    # Don't overwrite custom changes
    FileUtils.rm [ './src/env.d/99-custom', './src/profile.d/99-custom' ]

    [ '00-locale', '01-editor', '02-pager' ].each do |custom_env|
      # do not override the file if the current one exists
      FileUtils.rm "./src/env.d/#{custom_env}" if File.exist?("#{CREW_PREFIX}/etc/env.d/#{custom_env}")
    end

    FileUtils.cp_r Dir['./src/*'], "#{CREW_PREFIX}/etc/"
  end

  def self.postinstall
    # create custom files if not exist
    FileUtils.touch "#{CREW_PREFIX}/etc/env.d/99-custom"
    FileUtils.touch "#{CREW_PREFIX}/etc/profile.d/99-custom"

    # Write our rc files
    crew_rcfile = <<~CREW_PROFILE_EOF
      # DO NOT DELETE THIS LINE
      # See #{CREW_PREFIX}/etc/profile for further details
      source #{CREW_PREFIX}/etc/profile

      # Put your stuff under this comment

    CREW_PROFILE_EOF

    # append our #{crew_rcfile} to shell rc file
    [ '.bashrc', '.zshrc' ].select {|rc| File.exist?(rc) } .each do |rc|
      if File.readlines(rc, chomp: true).any? {|line| line == "source #{CREW_PREFIX}/etc/profile" }
        # Must write directly to HOME and not CREW_DEST_HOME to prevent chromebrew from
        # removing ~/.{bash,zsh}rc during reinstall
        orig_rc = File.read("#{HOME}/#{rc}")
        File.write("#{HOME}/.bashrc", crew_rcfile + orig_rc)
      end
    end
  end
end
