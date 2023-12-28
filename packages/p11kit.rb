require 'buildsystems/meson'

class P11kit < Meson
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.25.3'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.25.3_armv7l/p11kit-0.25.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.25.3_armv7l/p11kit-0.25.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.25.3_i686/p11kit-0.25.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/p11kit/0.25.3_x86_64/p11kit-0.25.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7f626c8bd485c1e5adb2a3561820840a4d9ba18a5ac14e6b00d6037795142533',
     armv7l: '7f626c8bd485c1e5adb2a3561820840a4d9ba18a5ac14e6b00d6037795142533',
       i686: '2793b90c951e3235b2d3f57f318294fa8b76ce2fe479b9b4b2f700438b945bd2',
     x86_64: 'c04c315bf005beccac0b3945d4c80c19383e0b7e6f3231f2ca8d7a634783088e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libffi' # R
  depends_on 'libtasn1' # R
end
