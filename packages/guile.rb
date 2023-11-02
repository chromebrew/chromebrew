require 'buildsystems/autotools'

class Guile < Autotools
  description 'Guile is designed to help programmers create flexible applications that can be extended by users or other programmers with plug-ins, modules, or scripts.'
  homepage 'http://www.gnu.org/software/guile/'
  version '3.0.9'
  license 'LGPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/guile/guile-3.0.9.tar.xz'
  source_sha256 '1a2625ac72b2366e95792f3fe758fd2df775b4044a90a4a9787326e66c0d750d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/guile/3.0.9_armv7l/guile-3.0.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/guile/3.0.9_armv7l/guile-3.0.9-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/guile/3.0.9_i686/guile-3.0.9-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/guile/3.0.9_x86_64/guile-3.0.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '906f359048d339cde70258acc75d01474c7fb7b45d97f3c8098111c0d688aae0',
     armv7l: '906f359048d339cde70258acc75d01474c7fb7b45d97f3c8098111c0d688aae0',
       i686: 'e9ff3777e595be590a6de7920496b2263647bb1a8938ffa04c6be7bf07b6a574',
     x86_64: '61d770df47c21761e6a35dd1d36cb50d70088e4f51988fa4636b69518a98c1f4'
  })

  depends_on 'bdwgc' # R
  depends_on 'diffutils' => :build
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libffi' # R
  depends_on 'libtool' => :build
  depends_on 'libunistring' # R
  depends_on 'readline' # R
end
