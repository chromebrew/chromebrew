require 'package'

class Pangomm < Package
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  version '1.0'
  license 'LGPL-2.1+'
  compatibility 'all'

  is_fake

  depends_on 'pangomm_1_4'
  depends_on 'pangomm_2_48'
end
