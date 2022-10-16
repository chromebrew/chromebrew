require 'package'

class Gcr < Package
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '4.0.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'all'

  is_fake

  depends_on 'gcr_3'
  depends_on 'gcr_4'
end

