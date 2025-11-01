require 'buildsystems/autotools'

class Pthread_stubs < Autotools
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org/wiki/'
  version '0.5'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/pthread-stubs.git'
  git_hashtag "libpthread-stubs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18ff6b89a73f42519aed2b30fb90b0cf7ae524bc88e65ad933b732f037cc5af2',
     armv7l: '18ff6b89a73f42519aed2b30fb90b0cf7ae524bc88e65ad933b732f037cc5af2',
       i686: '515e14bdb789cb689d7b1abc648e3961bb7126a52a8a9518e3741dc40c115b4d',
     x86_64: '22f7837cbf00a6115e1f178443a233e221547fab9e0a13872fd2cd8d89eb8347'
  })
end
