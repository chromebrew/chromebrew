require 'buildsystems/autotools'

class Findutils < Autotools
  description 'the basic directory searching utilities of the GNU operating system'
  homepage 'https://www.gnu.org/software/findutils/'
  version '4.9.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/findutils/findutils-4.9.0.tar.xz'
  source_sha256 'a2bfb8c09d436770edc59f50fa483e785b161a3b7b9d547573cb08065fd462fe'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/findutils/4.9.0_armv7l/findutils-4.9.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/findutils/4.9.0_armv7l/findutils-4.9.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/findutils/4.9.0_i686/findutils-4.9.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/findutils/4.9.0_x86_64/findutils-4.9.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5da7b4458d47e84fcddd9eddd27d202a3e8abce7e0d92684fbf912b155176075',
     armv7l: '5da7b4458d47e84fcddd9eddd27d202a3e8abce7e0d92684fbf912b155176075',
       i686: '7e02631ff1cc208365692179508851a701c695c17b71905d6d079e5148ec1b0f',
     x86_64: '0611927c689c7732037764964ba8fb2c41f22a9c594c978bd9ae6bf2e259f96e'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  configure_options '--without-selinux'
  run_tests
end
