# Adapted from Arch Linux gi-docgen PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gi-docgen/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_gi_docgen < Pip
  description 'Documentation generator for GObject-based libraries'
  homepage 'https://gnome.pages.gitlab.gnome.org/gi-docgen/'
  version "2026.1-#{CREW_PY_VER}"
  license 'Apache GPL3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5cf2df32b15852c290b6866ed7bced1fa888431adc1b4c24b7381375aa87dfc',
     armv7l: 'b5cf2df32b15852c290b6866ed7bced1fa888431adc1b4c24b7381375aa87dfc',
       i686: 'efac3665a78d56d3019974e2760328a6ed6a68bde021a4d7d1a4c5156b78215e',
     x86_64: 'e03af0c949c6a593542d2e0599ebbf7b647a0ff47f0d90922c1f8a5d0eaca127'
  })

  depends_on 'py3_jinja2'
  depends_on 'py3_markdown'
  depends_on 'py3_markupsafe'
  depends_on 'py3_pygments'
  depends_on 'python3' => :build

  no_source_build
  depends_on 'py3_toml'
  depends_on 'py3_typogrify'
end
