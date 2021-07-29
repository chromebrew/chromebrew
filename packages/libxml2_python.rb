require 'package'

class Libxml2_python < Package
  description 'Dummy package for py3_libxml2'
  homepage 'https://gitlab.gnome.org/GNOME/libxml2/'
  version '1'
  license 'MIT'
  compatibility 'all'

  is_fake

  depends_on 'py3_libxml2'
end
