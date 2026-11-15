require 'buildsystems/autotools'

class Libxfce4util < Autotools
  description 'Utility library for the Xfce4 desktop environment'
  homepage 'https://xfce.org/'
  version '4.20.1'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/libxfce4util/#{version.sub(/\.\d+$/, '')}/libxfce4util-#{version}.tar.bz2"
  source_sha256 '84bfc4daab9e466193540c3665eee42b2cf4d24e3f38fc3e8d1e0a2bebe3b8f1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'deba36f3031af6285fe9f559c43c2b65801c05392b19bc078743d8f9c4856651',
     armv7l: 'deba36f3031af6285fe9f559c43c2b65801c05392b19bc078743d8f9c4856651',
     x86_64: '536837f75962cd9cc51bbc50b51000365440e21a50d2be517151be9eb66098b2'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection'

  run_tests
end
