# Adapted from Arch Linux python-uc-micro-py PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-uc-micro-py/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_uc_micro_py < Pip
  description 'Micro subset of unicode data files for linkify-it-py projects'
  homepage 'https://github.com/tsutsu3/uc.micro-py'
  version '1.0.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '945bba18fc521b2d317bf7492b6971cb5386b1f7c5f6608f722262b04be64d0c',
     armv7l: '945bba18fc521b2d317bf7492b6971cb5386b1f7c5f6608f722262b04be64d0c',
       i686: 'e97f1c44019abd71017c6d14ca4185e4e11df9eae8a64a447d72b584cfffbf35',
     x86_64: '2886d2aa4c03c5f4c223dc1c3363e7130918b813a3333ef9a794bbc8adb417b0'
  })

  depends_on 'python3' => :build

  no_source_build
end
