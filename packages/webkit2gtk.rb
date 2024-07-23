require 'package'
require_relative 'webkit2gtk_4'

class Webkit2gtk < Package
  description Webkit2gtk_4.description
  homepage Webkit2gtk_4.homepage
  version Webkit2gtk_4.version
  license Webkit2gtk_4.license
  compatibility Webkit2gtk_4.compatibility

  is_fake

  depends_on 'webkit2gtk_4'
  depends_on 'webkit2gtk_4_1'
  depends_on 'webkitgtk_6'
end
