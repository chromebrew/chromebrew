# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'package'

class Py3_gi_docgen < Package
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  version '2022.1'
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gi-docgen.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_gi_docgen/2022.1_armv7l/py3_gi_docgen-2022.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_gi_docgen/2022.1_armv7l/py3_gi_docgen-2022.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_gi_docgen/2022.1_i686/py3_gi_docgen-2022.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_gi_docgen/2022.1_x86_64/py3_gi_docgen-2022.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '36720faa65b83944a74384038f50d878ae21b8f2cc076fae7feb3c065216ad91',
     armv7l: '36720faa65b83944a74384038f50d878ae21b8f2cc076fae7feb3c065216ad91',
       i686: '87267762d0360ac2f65c21a3a38efd186ccbe8d3f2869bdf9c0d64924fd40630',
     x86_64: '61da242a83085c27b3f1a7b4e4966fa28568f4654f430e638a7764e38111ba56'
  })

  depends_on 'py3_jinja2'
  depends_on 'py3_markdown'
  depends_on 'py3_markupsafe'
  depends_on 'py3_pygments'
  depends_on 'py3_setuptools' => :build
  gnome

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
