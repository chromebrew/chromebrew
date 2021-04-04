require 'package'

class Tepl < Package
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://wiki.gnome.org/Projects/Tepl'
  version '1.0'
  license 'LGPL-2.1+'
  compatibility 'all'

  is_fake

  depends_on 'tepl_5'
  depends_on 'tepl_6'
end
