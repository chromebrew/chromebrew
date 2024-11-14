require 'buildsystems/autotools'

class Mc < Autotools
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.32'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/MidnightCommander/mc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2a24066767225d5b6eb92e83fea3e17fb30877403dbe1fb17f43646164547b2',
     armv7l: 'e2a24066767225d5b6eb92e83fea3e17fb30877403dbe1fb17f43646164547b2',
       i686: '2e8cd28f3e608407f5a9eaae4fc664142db54302e56e4f8f4b5d1b0fc600608f',
     x86_64: '96b9254b193ec6af096fc2a8d535c825356a5ee8faa271708df10b85520e220c'
  })

  depends_on 'glib' => :build
  depends_on 'aspell' => :build
  depends_on 'gpm'

  run_tests
end
