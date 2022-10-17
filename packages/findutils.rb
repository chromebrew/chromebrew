require 'buildsystems/autotools/v1'

class Findutils < Autotools_v1
  description 'The basic directory searching utilities of the GNU operating system.'
  homepage 'https://www.gnu.org/software/findutils/'
  version '4.9.0'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/findutils/findutils-4.9.0.tar.xz'
  source_sha256 'a2bfb8c09d436770edc59f50fa483e785b161a3b7b9d547573cb08065fd462fe'

  depends_on 'python3'

  configure_options '--without-selinux'
end
