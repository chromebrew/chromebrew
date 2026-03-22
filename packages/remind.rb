require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.02.05'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '8124d0a057aebfaba30eb63a8c331b3c5e60dd15d24d8e6492316d1536e36305'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0bbb636ee6ab13fe4c50c6bc028d9df9ba430325c4902b2c4cacc2b3ea07c665',
     armv7l: '0bbb636ee6ab13fe4c50c6bc028d9df9ba430325c4902b2c4cacc2b3ea07c665',
       i686: 'c6c7eeb41af90b890553e9b15b76b0be1708951306cc92030d08c8d458c7d285',
     x86_64: 'bd7a095f325e81effc03ee2e6caf5e32b794e800441f3168d36a91090adc15e6'
  })

  depends_on 'glibc' => :executable
  depends_on 'readline' => :executable
  depends_on 'tk' unless ARCH.eql?('i686') # Needed for tkremind.

  autotools_install_extras do
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.touch "#{CREW_DEST_HOME}/.reminders"
  end
end
