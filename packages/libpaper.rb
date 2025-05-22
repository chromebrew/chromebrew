require 'buildsystems/autotools'

class Libpaper < Autotools
  description 'Library and command-line tools for configuring and getting information on paper sizes.'
  homepage 'https://github.com/rrthomas/libpaper'
  version '2.2.5'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/rrthomas/libpaper.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '311224c0e1461aa3333816f625d386ed654a9a0873796f7ef4889e10336879ab',
     armv7l: '311224c0e1461aa3333816f625d386ed654a9a0873796f7ef4889e10336879ab',
       i686: 'd4e0d32bb633f5c7df21d5b234f2ed71f482e8341fc0dacd9b0e0972d2a5181b',
     x86_64: '1bd10e468924df67a70e49e6aff58d3c7dbac500e1ce735fdd701cf341d62dca'
  })

  depends_on 'gnupg' => :build
  depends_on 'help2man' => :build

  autotools_configure_options '--enable-relocatable'

  run_tests
end
