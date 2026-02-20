# Adapted from Arch Linux python-rich PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-rich/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_rich < Pip
  description 'Render rich text, tables, progress bars, syntax highlighting, markdown and more to the terminal'
  homepage 'https://github.com/willmcgugan/rich'
  version "14.3.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6bac760000109fa72fac606295579883d634c596f04063a723f06964b9f9561c',
     armv7l: '6bac760000109fa72fac606295579883d634c596f04063a723f06964b9f9561c',
       i686: 'fc99f4d427588d89bb5b99fa6410310c9d1d2ac2630ba7342f5abc034fde74a0',
     x86_64: 'c51bcb28684bf1106d39ecceb1adc228aad699f647568987bd81978692951c59'
  })

  depends_on 'py3_colorama'
  depends_on 'py3_markdown_it_py'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build

  no_source_build
end
