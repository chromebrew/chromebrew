require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  @_ver = '0.0.8'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://github.com/chromebrew/crew-profile-base/archive/#{@_ver}.tar.gz"
  source_sha256 '95642b0a8c7fe83ade2338ca68425ebf4598705633e8c0655cce8991b04697b7'

  no_compile_needed
  no_patchelf

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/profile.d"

    # dbus file moved to dbus package, so remove it.
    FileUtils.rm_f './src/env.d/04-dbus'

    # Don't overwrite custom changes
    %w[01-locale 02-editor 03-pager 99-custom].each do |custom_files|
      FileUtils.rm "./src/env.d/#{custom_files}" if File.exist?("#{CREW_PREFIX}/etc/env.d/#{custom_files}")
    end

    FileUtils.cp_r Dir['./src/*'], "#{CREW_DEST_PREFIX}/etc/"
  end

  def self.postinstall
    # Write our rc files
    crew_rc_source_line = "source #{CREW_PREFIX}/etc/profile"
    crew_rcfile = <<~CREW_PROFILE_EOF
      # DO NOT DELETE THIS LINE
      # See #{CREW_PREFIX}/etc/profile for further details
      #{crew_rc_source_line}

      # Put your stuff under this comment

    CREW_PROFILE_EOF

    # append our #{crew_rcfile} to shell rc files (if exist)
    ['.bashrc', '.zshrc'].each do |rc|
      rc_path = File.join(HOME, rc)

      next unless File.exist?(rc_path)

      rc_file = File.readlines(rc_path, chomp: true)

      # remove duplicated `source` lines (if any)
      if rc_file.count(crew_rc_source_line) > 1
        puts "Removing duplicated `source` lines in #{rc_path}...".yellow
        first_source_line_index = rc_file.find_index(crew_rc_source_line)

        # delete all `source` lines
        rc_file.delete(crew_rc_source_line)

        # re-add the first `source` line
        rc_file.insert(first_source_line_index, crew_rc_source_line)
      end

      # append our rc string to the beginning of the rc file (if not exist)
      if rc_file.none? { |line| line == "source #{CREW_PREFIX}/etc/profile" }
        puts "Appending `#{crew_rc_source_line}` to the beginning of #{rc_path}...".yellow
        rc_file.unshift(crew_rcfile.lines(chomp: true))
      end

      # save changes
      File.write rc_path, rc_file.join("\n")
    end
  end
end
