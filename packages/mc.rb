require 'buildsystems/autotools'

class Mc < Autotools
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.31'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/MidnightCommander/mc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f12829b011cfbf97e92b3cb66773750899c306bdd1fe39ecec95d0658f05466f',
     armv7l: 'f12829b011cfbf97e92b3cb66773750899c306bdd1fe39ecec95d0658f05466f',
       i686: 'c7f67f4a9bf4e36e04082120f57cd62df023ca5fbf9207f3d8058713c82b68f3',
     x86_64: 'a3d9d1f1e19baea67d2c2fab13b0c81e65915cd8653fe351951fd6b9109292f5'
  })

  depends_on 'glib' => :build
  depends_on 'aspell' => :build
  depends_on 'gpm'

  run_tests
end
