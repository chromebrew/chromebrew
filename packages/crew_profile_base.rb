require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  version '0.0.1-pre1'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-profile-base/releases/download/0.0.1-pre2/crew-profile-base-0.0.1-pre2.tar.xz'
  source_sha256 '8cb774e48faa6ad3f813ef96de52cbf89f7ba512a9e9b843314f1bbc58973212'

  binary_url ({

  })
  binary_sha256 ({

  })

  def self.preinstall
    @rcfile = <<~EOF
      # DO NOT DELETE THIS LINE
      # See #{CREW_PREFIX}/etc/profile for further details
      source #{CREW_PREFIX}/etc/profile

      # Put your stuff under this comment
    EOF
    IO.write(".bashrc", @rcfile)
    IO.write(".zshrc", @rcfile)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.cp_r Dir.glob('./src/*'), "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.cp ".bashrc", "#{CREW_DEST_HOME}"
    FileUtils.cp ".zshrc", "#{CREW_DEST_HOME}"
  end
end
