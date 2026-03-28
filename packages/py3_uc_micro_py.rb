# Adapted from Arch Linux python-uc-micro-py PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-uc-micro-py/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_uc_micro_py < Pip
  description 'Micro subset of unicode data files for linkify-it-py projects'
  homepage 'https://github.com/tsutsu3/uc.micro-py'
  version '2.0.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db0296d9ea697c3785807dbca6fdd4d51981bdb70273cbbfba48160bdbe14080',
     armv7l: 'db0296d9ea697c3785807dbca6fdd4d51981bdb70273cbbfba48160bdbe14080',
       i686: '7cdbb42d5639c5b3147355f7691eda69e51928f765e1c40f55177b7ef79e1e8c',
     x86_64: 'fd2cb1463962f28e5abd9e986574551c49b032bb72492cb056f78a7092adeb38'
  })

  depends_on 'python3' => :logical

  no_source_build
end
