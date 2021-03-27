require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  version '0.0.1-pre3'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-profile-base/archive/refs/tags/0.0.1-pre3.tar.gz'
  source_sha256 '01308b9342107a08f076f8c10e6844f03ff7301d28012ca8374e4f0f1bc431c8'

  # This package shouldn't have binaries.
  binary_url ({

  })
  binary_sha256 ({

  })

  def self.preinstall
    @_str = "source #{CREW_PREFIX}/etc/profile"
    FileUtils.mv "#{HOME}/.bashrc", "#{HOME}/.bashrc.bak" unless `grep -c '#{@_str}' #{HOME}/.bashrc`.to_i.zero?
    FileUtils.mv "#{HOME}/.zshrc", "#{HOME}/.zshrc.bak" unless `grep -c '#{@_str}' #{HOME}/.zshrc`.to_i.zero?
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    @rcfile = <<~EOF
      # DO NOT DELETE THIS LINE
      # See #{CREW_PREFIX}/etc/profile for further details
      source #{CREW_PREFIX}/etc/profile

      # Put your stuff under this comment
    EOF
    IO.write("#{CREW_DEST_HOME}/.bashrc", @rcfile)
    IO.write("#{CREW_DEST_HOME}/.zshrc", @rcfile)

    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.cp_r Dir.glob('./src/*'), "#{CREW_DEST_PREFIX}/etc/"
  end

  def self.postinstall
    system "cat #{HOME}/.bashrc.bak >> #{HOME}/.bashrc" if File.exists? "#{HOME}/.bashrc.bak"
    system "cat #{HOME}/.zshrc.bak >> #{HOME}/.zshrc" if File.exists? "#{HOME}/.zshrc.bak"
    puts
    puts "IT IS IMPERATIVE TO THE FUNCTION OF CHROMEBREW FOR"
    puts "#{HOME}/.bashrc to contain the line 'source #{CREW_PREFIX}/etc/profile'."
    puts "This should have happened automatically unless you already have a #{HOME}/.bashrc file."
    puts "If the line doesn't exist, add it now."
    puts
  end
end
