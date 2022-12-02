# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'package'

class Py3_gi_docgen < Package
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  @_ver = '2022.2'
  version "#{@_ver}-py3.11"
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gi-docgen.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_gi_docgen/2022.2-py3.11_armv7l/py3_gi_docgen-2022.2-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_gi_docgen/2022.2-py3.11_armv7l/py3_gi_docgen-2022.2-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_gi_docgen/2022.2-py3.11_i686/py3_gi_docgen-2022.2-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_gi_docgen/2022.2-py3.11_x86_64/py3_gi_docgen-2022.2-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a78bcb45f4fec353fe56b0b41cfc5f57c40af41b7110eba2133a4b37aaa39800',
     armv7l: 'a78bcb45f4fec353fe56b0b41cfc5f57c40af41b7110eba2133a4b37aaa39800',
       i686: '06a00c7177601748ea9819233281843c139c2f2997fda1c90e7e3eb760a641ad',
     x86_64: '9a0c6863028c8a81fdc247b6a4ef8905ff03d332072ea73be8082775c2bf1f34'
  })

  depends_on 'py3_jinja2'
  depends_on 'py3_markdown'
  depends_on 'py3_markupsafe'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build
  depends_on 'py3_toml'
  depends_on 'py3_typogrify'

  gnome

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
