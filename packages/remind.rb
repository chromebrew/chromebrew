require 'buildsystems/autotools'

class Remind < Autotools
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://dianne.skoll.ca/projects/remind/'
  version '06.03.01'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://dianne.skoll.ca/projects/remind/download/remind-#{version}.tar.gz"
  source_sha256 '16161aba1b0494bbdac375a7fffd4a22d8e46648dc62608f4c00e731e985b7ad'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dad81a16198f805bbc74ff05de25ecfd82e445c4b0385b0a910b5ff9342862ef',
     armv7l: 'dad81a16198f805bbc74ff05de25ecfd82e445c4b0385b0a910b5ff9342862ef',
       i686: '99270c57275bb679a52edfc2c519a47c54ca8b2048d55ae8d5a4dd480d097d88',
     x86_64: 'fb090954be480dd42fd33df906784381a56ecbf0bf4410618bdb9741b7b36713'
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
