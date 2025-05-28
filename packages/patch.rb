require 'buildsystems/autotools'

class Patch < Autotools
  description 'Patch takes a patch file containing a difference listing produced by the diff program and applies those differences to one or more original files, producing patched versions.'
  homepage 'https://www.gnu.org/software/patch/'
  version '2.8'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/patch/patch-#{version}.tar.xz"
  source_sha256 'f87cee69eec2b4fcbf60a396b030ad6aa3415f192aa5f7ee84cad5e11f7f5ae3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18339cb6ba301d4c5e6274d09c9bf51c1a14f715d485e0923ef9b0c4a689ee60',
     armv7l: '18339cb6ba301d4c5e6274d09c9bf51c1a14f715d485e0923ef9b0c4a689ee60',
       i686: 'ba54143694d67822637f7b76865538c7968343cffb691ee0fed2db73584f9d10',
     x86_64: 'b6805b38f3cb66882c6ba9d17297b811b625f71e69dec686adb1212f5656b6ea'
  })

  depends_on 'attr' # R
  depends_on 'glibc' # R

  autotools_configure_options '--disable-year2038' unless ARCH.include?('x86_64')

  run_tests
end
