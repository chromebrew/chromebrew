require 'buildsystems/meson'

class Gexiv2 < Meson
  description 'gexiv2 is a GObject wrapper around the Exiv2 photo metadata library.'
  homepage 'https://wiki.gnome.org/Projects/gexiv2/'
  version '0.16.0'
  license 'LGPL-2.1+ and GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gexiv2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b1a205a7d8aa20fa47c8926c7dcb5575ddbc3e193ec2e41bfca1274c3774947',
     armv7l: '6b1a205a7d8aa20fa47c8926c7dcb5575ddbc3e193ec2e41bfca1274c3774947',
     x86_64: 'b199d4c0d0d6870144bf54af9db29f0f3a653f59f4683085521071c00f760763'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'libexiv2' # R

  gnome
end
