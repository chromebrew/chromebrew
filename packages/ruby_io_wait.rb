require 'buildsystems/ruby'

class Ruby_io_wait < RUBY
  description 'Waits until io is readable or writable without blocking.'
  homepage 'https://github.com/ruby/io-wait'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '20b99bf56af0ca566544e8a8663f25170b511a2dce184ddff0921cf301d1d403',
     armv7l: '20b99bf56af0ca566544e8a8663f25170b511a2dce184ddff0921cf301d1d403',
       i686: 'a4c5c6233b17e9f55126e5dafcf2f4f4a5cab1428deae156a41d4aa9b2eb7db8',
     x86_64: 'b67d1759d016850561239005b1c7ac396faf5459fc6dd1f166545f28613d81f0'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
