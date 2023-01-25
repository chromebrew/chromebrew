require 'package'

class Webkit2gtk < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.32.0'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'

  is_fake

  depends_on 'webkit2gtk_4'
  depends_on 'webkit2gtk_4_1'
  depends_on 'webkit2gtk_5'
end
