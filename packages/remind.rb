require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.03.06'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '19518dfa6ab3695749e74b26b664a7134b573ddd03f0a7a6fee3867868d6fd58'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08f2eb4a670663c2e8b004d399cb0dab6bf0c6808509608e583d79722b917263',
     armv7l: '08f2eb4a670663c2e8b004d399cb0dab6bf0c6808509608e583d79722b917263',
       i686: 'baaa9d6d7e5aa4e29f2cf0475233dd521f78f751e4780920713213725e3dd35d',
     x86_64: 'da2275731eb7575bdff938e0b0f20ad92ce30afdb7fdf53166f1664a15d0ee6f'
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
