require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.02.06'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '2fc703a54b593217d5cba00bee2a8ee796030ea63bdc98592ae8c3f19352dacd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80a186ca12728200b8816316b055e21cec242322cb5a20e9555977d33004af6a',
     armv7l: '80a186ca12728200b8816316b055e21cec242322cb5a20e9555977d33004af6a',
       i686: '2e8b7e372405d98e825ebb53761b6ebf3d80272f918dcd27b8a5ec9f73e26543',
     x86_64: '4ace35ae190f5ec81c295ea27ae01ce5f3effe6945954efc0b71f8776ce314f0'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'readline' => :executable
  depends_on 'tk' unless ARCH.eql?('i686') # Needed for tkremind.

  autotools_install_extras do
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.touch "#{CREW_DEST_HOME}/.reminders"
  end
end
