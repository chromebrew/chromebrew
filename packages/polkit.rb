require 'buildsystems/meson'

class Polkit < Meson
  description 'Application development toolkit for controlling system-wide privileges'
  homepage 'https://github.com/polkit-org/polkit'
  version '125'
  license 'LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/polkit-org/polkit.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '049b8152177810491fd8a7af7ba60707c25806cc74a7ffcb7e46f6351fb8a024',
     armv7l: '049b8152177810491fd8a7af7ba60707c25806cc74a7ffcb7e46f6351fb8a024',
     x86_64: 'd718513f21699196b8524a8f04a089ab7eb887fc273a83cf490636b54aca98c8'
  })

  depends_on 'duktape'
  depends_on 'elogind'
  depends_on 'expat'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'linux_pam' # R

  meson_options "-Dsession_tracking=elogind -Dsystemdsystemunitdir=#{CREW_PREFIX}/etc/elogind"
  run_tests
end
