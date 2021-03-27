require 'package'

class Crew_profile_base < Package
  description 'Crew-profile-base sets up Chromebrew\'s environment capabilities.'
  homepage 'https://github.com/chromebrew/crew-profile-base'
  version '0.0.1-pre3'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://github.com/chromebrew/crew-profile-base/archive/refs/tags/0.0.1-pre3.tar.gz'
  source_sha256 '01308b9342107a08f076f8c10e6844f03ff7301d28012ca8374e4f0f1bc431c8'

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
    IO.write("#{CREW_DEST_HOME}/.bashrc", @rcfile)
    IO.write("#{CREW_DEST_HOME}/.zshrc", @rcfile)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/"
    FileUtils.cp_r Dir.glob('./src/*'), "#{CREW_DEST_PREFIX}/etc/"
  end
end
