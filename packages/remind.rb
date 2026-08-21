require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.03.00'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '5d7b8f9b80944abfd431c153cdb64b857d034bf7915eefee7a3e2dbb6e12260f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c9aba6580d9818095ac385652bed3b06fa3b76ab2a87108ec6cd54a4cdda497',
     armv7l: '0c9aba6580d9818095ac385652bed3b06fa3b76ab2a87108ec6cd54a4cdda497',
       i686: 'ecc39a6f55bff757859863c0f52fb93b49794cc7166234f6d7ffc3888c69ec6d',
     x86_64: 'bfac245539927058411e5329f8f7c32039ab92e7073af623405f70a53a9b6a02'
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
