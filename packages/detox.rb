require 'buildsystems/autotools'

class Detox < Autotools
  description 'detox is a program that renames files to make them easier to work with under Linux and other Unix-like operating systems.'
  homepage 'https://github.com/dharple/detox'
  version '2.0.0'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/dharple/detox.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '997436983cee04e7d368d74709b77ded41959793c0c9536aedb6d065517d6856',
     armv7l: '997436983cee04e7d368d74709b77ded41959793c0c9536aedb6d065517d6856',
       i686: 'e8db275366a3402c1f293a2de4ae2734438e606cbe7e807144d581c9cb1a3b30',
     x86_64: 'c6841edbd7daf7c0fda861de3d30546f2108f5207bc1b8dab6529095c5fb3724'
  })
end
