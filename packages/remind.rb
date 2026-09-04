require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.03.02'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 'a1c783cd0c9bc6958e1e01e8970a514249b0a7a01349d5d1639f2dace7bcf585'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '92a6f6170fdcc553dfa3fce729b92eddc896ec61c4eaa6a799c9bddd2f881eb2',
     armv7l: '92a6f6170fdcc553dfa3fce729b92eddc896ec61c4eaa6a799c9bddd2f881eb2',
       i686: '9138131d665340662ad67426901b2a5db69bad4e7304930fbf99edc258da3ab9',
     x86_64: 'c16df3a4c93138167db5160f8a9d09689a0eadbe6655f7007ea11813becf1b07'
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
