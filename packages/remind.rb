require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.03.07'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '38b2afaf4cc2ef5642c8ea85c61c3658d575a381be58baf4a5a05f419a9637a2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b88319cd9bfa17abf5a0de4412a0526882135b945c19d4527d42d73a894101b',
     armv7l: '1b88319cd9bfa17abf5a0de4412a0526882135b945c19d4527d42d73a894101b',
       i686: '43f64c996ca819a937ebbe7c74eeccd16390dec06f3ef3c18655fbf48fc62490',
     x86_64: 'eda1e62fe905a5c3689ea626ecd52f4d791efcba74038f481ef081c2b2f0c7ed'
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
