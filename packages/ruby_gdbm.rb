require 'buildsystems/ruby'

class Ruby_gdbm < RUBY
  description 'Ruby extension for GNU dbm.'
  homepage 'https://github.com/ruby/gdbm'
  version "2.1.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'cec83f701d7dfa462a81cbf0c261c4132fa0184e0c89d9ab50a3b890ac0f2bcb',
     armv7l: 'cec83f701d7dfa462a81cbf0c261c4132fa0184e0c89d9ab50a3b890ac0f2bcb',
       i686: '37eed9c5c1bc05c8d421b0353f380593709fbb2fa7769e54a6c7ec26dcd8f5b7',
     x86_64: '729267b6592f7de532659e915d244a9217336025ce18557b3a6abc60496f506d'
  })

  conflicts_ok
  gem_compile_needed
end
