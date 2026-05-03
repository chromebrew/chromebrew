require 'buildsystems/cmake'

class Libtommath < CMake
  description 'LibTomMath is a free open source portable number theoretic multiple-precision integer library written entirely in C.'
  homepage 'https://www.libtom.net/'
  version '1.3.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libtom/libtommath.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7bea253ed5d15167572dc66a386df0ad0b8a185a9116db926f3d892feae0079e',
     armv7l: '7bea253ed5d15167572dc66a386df0ad0b8a185a9116db926f3d892feae0079e',
       i686: '4ffacf3d28bb9b3cec987b382c727f77a85c7799364de369acf0a785006b3e48',
     x86_64: '96802e0c96a914ef2b1ef8dbcedb346678f79bf3fffcff220c85af8704e6dc58'
  })
end
