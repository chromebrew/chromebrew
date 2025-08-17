require 'buildsystems/autotools'

class Mate_common < Autotools
  description 'Common files for development of MATE packages.'
  homepage 'https://mate-desktop.org'
  version '1.28.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://pub.mate-desktop.org/releases/#{version.rpartition('.')[0]}/mate-common-#{version}.tar.xz"
  source_sha256 '42b7c2cee268f71d7e1c1ad4f69bcda0ecd65578a96722187c6b76378d26ba0a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0be6546d77afd05e304e5d2692029d0d97aceed83c5fa6b74ea0295d17a606a2',
     armv7l: '0be6546d77afd05e304e5d2692029d0d97aceed83c5fa6b74ea0295d17a606a2',
     x86_64: 'a147018439cc4635bf792e2323e24bf9927694289cc9986dc4dcb36eabf47ba9'
  })

  depends_on 'gtk_doc'
end
