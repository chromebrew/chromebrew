require 'buildsystems/autotools'

class Libspiro < Autotools
  description 'LibSpiro is an adaptation of Spiro formula and functions into a sharable library'
  homepage 'https://github.com/fontforge/libspiro'
  version '20240903'
  license 'GPL3+'
  compatibility 'all'
  source_url 'https://github.com/fontforge/libspiro.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efbea45ee35af7dfc07638377d1b7501ab385bb8fa868b77f9af09abbb638056',
     armv7l: 'efbea45ee35af7dfc07638377d1b7501ab385bb8fa868b77f9af09abbb638056',
       i686: '098a3eaa0ae145c76d8acd3a06ad5a7838e3e478058c9b7c95e3d4a9f5f108f3',
     x86_64: '5ad57ae880ddbf05cc340bc782b59e50c645a23d930225e56c960950ac757611'
  })

  run_tests
end
