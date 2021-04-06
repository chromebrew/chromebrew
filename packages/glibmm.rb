require 'package'

class Glibmm < Package
  description 'C++ bindings for GLib'
  homepage 'https://www.gtkmm.org'
  version '1.0'
  license 'LGPL-2.1+'
  compatibility 'all'

  is_fake

  depends_on 'glibmm_2_4'
  depends_on 'glibmm_2_68'
end
