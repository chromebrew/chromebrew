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
    aarch64: '65c999d122794719e33d424824c74c5652e096cfc00602c3d4c3735580ed890c',
     armv7l: '65c999d122794719e33d424824c74c5652e096cfc00602c3d4c3735580ed890c',
       i686: '7fb80e8f5ceb7f4203648bf8e31cdf1447ff2e9b7a705b8cb915b21988d4ac26',
     x86_64: 'b032122aca3708e986ea8ff5b1b6a978407ee9c7370006c560e3c865b4242cfd'
  })

  depends_on 'py3_jinja2'
  depends_on 'py3_markdown'
  depends_on 'py3_markupsafe'
  depends_on 'py3_pygments'
  depends_on 'py3_setuptools' => :build
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
