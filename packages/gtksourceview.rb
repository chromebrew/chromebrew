require 'package'

class Gtksourceview < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  version '1.0'
  license 'LGPL-2.1+'
  compatibility 'all'

  is_fake

  depends_on 'gtksourceview_4'
  depends_on 'gtksourceview_5'
end
