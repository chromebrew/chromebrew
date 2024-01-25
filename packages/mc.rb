require 'buildsystems/autotools'

class Mc < Autotools
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.30'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/MidnightCommander/mc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3f46f94869391c4f9ce09490972e9a7fdfd7d67f6b6b15fa2bcf667b2dc765c',
     armv7l: 'a3f46f94869391c4f9ce09490972e9a7fdfd7d67f6b6b15fa2bcf667b2dc765c',
       i686: '509e05a162b01b54565c810759d3fc6e7c1a220cb959bdd1ccf4aa589daf383c',
     x86_64: 'eab6581c138140a5a3802682e6dcde24d8f44d4bf0b6914072b6d2fec7661580'
  })

  depends_on 'glib' => :build
  depends_on 'aspell' => :build
  depends_on 'gpm'

  run_tests
end
