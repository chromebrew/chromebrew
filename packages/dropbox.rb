require 'buildsystems/autotools'

class Dropbox < Autotools
  description 'Dropbox simplifies the way you create, share and collaborate.  Bring your photos, docs, and videos anywhere and keep your files safe.'
  homepage 'https://www.dropbox.com/'
  version '2024.04.17'
  license 'GPL3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/dropbox/nautilus-dropbox'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '329c88079724d27b65f31f581169f62df97c157b1c960a63f06f9cfe81674946',
     armv7l: '329c88079724d27b65f31f581169f62df97c157b1c960a63f06f9cfe81674946',
     x86_64: '58c3085b1cd6d8c969d1d23a3e2b589af842d66263c073eb65f3035afbe16865'
  })

  depends_on 'glib'
  depends_on 'gnome_common'
  depends_on 'gtk4'
  depends_on 'nautilus'
  depends_on 'py3_docutils' => :build
  depends_on 'py3_gi_docgen' => :build

  # We could rebuild gpgme with python bindings here to avoid a warning when installing.
  def self.postinstall
    ExitMessage.add 'To finish the installation, execute `dropbox start -i`.'
  end
end
