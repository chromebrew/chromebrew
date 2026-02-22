require 'buildsystems/autotools'

class Mc < Autotools
  description 'GNU Midnight Commander is a visual file manager'
  homepage 'http://midnight-commander.org/'
  version '4.8.33'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/MidnightCommander/mc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e172ee211ea018e8b25000857b8ded88adcebaf0d1f965b977efb3a62b7fb8bb',
     armv7l: 'e172ee211ea018e8b25000857b8ded88adcebaf0d1f965b977efb3a62b7fb8bb',
       i686: '2076782eb634f221f3ce2e5cb8adcf8e95959920178a1b2d575679942014fb51',
     x86_64: 'bd6a5409fdec7c666d211581808ac91e3f27d32ba80168d2532134696057f680'
  })

  depends_on 'aspell' => :build
  depends_on 'check' => :build
  depends_on 'e2fsprogs' => :executable_only
  depends_on 'glib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'gpm' => :executable_only
  depends_on 'graphviz' => :build unless ARCH.eql?('i686')
  depends_on 'slang' => :executable_only

  run_tests
end
