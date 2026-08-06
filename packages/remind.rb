require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.02.10'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '746aa587e72c32393037773fac976b6b7b29878f4eb8a728ad87f729d9a3efe6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1761bcd76f4dac9efe9a85c6295d1a27b079cf6fa854290656114ea3fa35b59',
     armv7l: 'e1761bcd76f4dac9efe9a85c6295d1a27b079cf6fa854290656114ea3fa35b59',
       i686: '31a1d0657266976b814aafa7c32db8b52b3d2a636b069ee0b1a18658bbe9d323',
     x86_64: 'b34d04b2c54b3bfe35659f71d9f724d7a92bc8cc755dd8cc3624c5335fde2a5d'
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
