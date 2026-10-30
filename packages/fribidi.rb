require 'buildsystems/meson'

class Fribidi < Meson
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://github.com/fribidi/fribidi'
  version '1.0.18'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/fribidi/fribidi.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b974097e6de6d47f71d83af60751fbc541d20f74b8a15c81b94dae356bcb97e9',
     armv7l: 'b974097e6de6d47f71d83af60751fbc541d20f74b8a15c81b94dae356bcb97e9',
       i686: '835795f739d2e90b189417800db1fc173b0a8194b20640a94e3da94f1d7a095b',
     x86_64: 'f7ac83be7966a332dc94f4416ba420830f30de79785bfd2dfbcd388afdec76d1'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  meson_options '-Ddocs=false \
      -Dtests=false'
end
