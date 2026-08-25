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
    aarch64: 'c5247546d1eacd28aad452bdd30fbec0dbc300f31ad2d059866410eaaf1b4a17',
     armv7l: 'c5247546d1eacd28aad452bdd30fbec0dbc300f31ad2d059866410eaaf1b4a17',
       i686: 'a1938cdeba742ce0c5970c504cb4e577776a3b65bd372bc65d1c0418834e7609',
     x86_64: '9da0d88634a8193c7bf7d9fb31ab9728401632e15ccaa8a02e8ac111ab505b52'
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
