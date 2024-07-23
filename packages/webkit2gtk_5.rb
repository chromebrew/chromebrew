require 'package'
require_relative 'webkitgtk_6'

class Webkit2gtk_5 < Package
  description Webkitgtk_6.description
  homepage Webkitgtk_6.homepage
  version Webkitgtk_6.version
  license Webkitgtk_6.license
  compatibility Webkitgtk_6.compatibility

  is_fake

  depends_on 'webkitgtk_6'
end
