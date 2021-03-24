require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  version '0.0.1-pre1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-profile-base/releases/download/0.0.1-pre1/crew-profile-base-0.0.1-pre1.tar.xz'
  source_sha256 '22c41f65b2d6c3b858242216703230354f2697b4d6f410826f4a633da155dd98'

  binary_url ({

  })
  binary_sha256 ({

  })

  def self.preinstall
    @rcfile = <<~EOF
      # DO NOT DELETE THIS LINE
      # See /usr/local/etc/profile for further details
      source /usr/local/etc/profile

      # Put your stuff under this comment
    EOF
    IO.write(".bashrc", @rcfile)
    IO.write(".zshrc", @rcfile)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.mv "env.d", "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.mv "profile.d", "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.mv "profile", "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.mv ".bashrc", "#{CREW_DEST_HOME}"
    FileUtils.mv ".zshrc", "#{CREW_DEST_HOME}"
  end
end
