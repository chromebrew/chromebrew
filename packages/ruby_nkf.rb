require 'buildsystems/ruby'

class Ruby_nkf < RUBY
  description 'Ruby extension for Network Kanji Filter'
  homepage 'https://github.com/ruby/nkf'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '3e1bc5743143a8ff0cf39ea3a56719b8e4f4422497e8d6c6e014124e28c9eba7',
     armv7l: '3e1bc5743143a8ff0cf39ea3a56719b8e4f4422497e8d6c6e014124e28c9eba7',
       i686: '2bf3dddcd0320bbe26834b01bfd690df29cb47e18f837312a34c7b1334008f4c',
     x86_64: '10eb207d3456b09935161ca3caf5b3c397f35a1c945abb8fab119211a8e9abce'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
