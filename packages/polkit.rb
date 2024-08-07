require 'buildsystems/meson'

class Polkit < Meson
  description 'Application development toolkit for controlling system-wide privileges'
  homepage 'https://github.com/polkit-org/polkit'
  version '124-eafbf7d'
  license 'LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/polkit-org/polkit.git'
  git_hashtag 'eafbf7ded1b1b0424fb7da16c32629e43c71af27'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '619ae1856a98ffaf5aa0fa4e81b21f5b73b2e0db3f25d30d8f26c1b535b50980',
     armv7l: '619ae1856a98ffaf5aa0fa4e81b21f5b73b2e0db3f25d30d8f26c1b535b50980',
     x86_64: 'bdc6e6282b546beb5188347e7b5a0956367fbd85a5859bdfbed5cfbd2cc8c6e3'
  })

  depends_on 'duktape'
  depends_on 'elogind'
  depends_on 'expat'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'linux_pam' # R

  def self.patch
    # meson: do not depend on systemd
    Downloader.download 'https://patch-diff.githubusercontent.com/raw/polkit-org/polkit/pull/471.patch', '50641d00cb837f1a97623dd0ad3d49d810ef977fcef6ef10cd88b61b64650ede'
    system 'git apply 471.patch'
  end

  meson_options "-Dsession_tracking=elogind -Dsystemdsystemunitdir=#{CREW_PREFIX}/etc/elogind"
  run_tests
end
