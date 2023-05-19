require 'package'
require_relative 'webkitgtk_6'

class Webkit2gtk_5 < Package
  description Webkitgtk_6.description.to_s
  homepage Webkitgtk_6.homepage.to_s
  version Webkitgtk_6.version.to_s
  license Webkitgtk_6.license.to_s
  compatibility Webkitgtk_6.compatibility.to_s

  is_fake

  depends_on 'webkitgtk_6'
end
