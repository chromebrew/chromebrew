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
    aarch64: '9356346e2defe3f6c1ed55651c19ba6423ff879481276f832becf6e637dcbc65',
     armv7l: '9356346e2defe3f6c1ed55651c19ba6423ff879481276f832becf6e637dcbc65',
       i686: '3d0935509c9ceb193d839d2e2d6222f98d1d475e725d9f83a8cb1f16c9c3ec04',
     x86_64: 'f508f4dc808f517c9b6be555790437efbf5b22563020bf36da7e1ab307ddc085'
  })

  depends_on 'glibc' # R

  run_tests
end
