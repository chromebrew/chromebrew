require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.03.04'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 'c56976b4bb3f3c838b4861f35b1a0ed80695b6a5e27c7736763c6518a884218b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '28503b9702e3f6ee2ce4f7315b5e98a26fce48ea5d718e28d5e2a127f9611975',
     armv7l: '28503b9702e3f6ee2ce4f7315b5e98a26fce48ea5d718e28d5e2a127f9611975',
       i686: 'd3e56d9a9d24cc708fb80d16fed1f6ba542cc076bc7feece3905fa88210f2539',
     x86_64: '724a11b856de604d95675021c097fa8957f17042d62c8d6107599c36ce334f6a'
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
