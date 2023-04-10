require 'package'
require_relative 'webkit2gtk_4'

class Webkit2gtk < Package
  description Webkit2gtk_4.description.to_s
  homepage Webkit2gtk_4.homepage.to_s
  version Webkit2gtk_4.version.to_s
  license Webkit2gtk_4.license.to_s
  compatibility Webkit2gtk_4.compatibility.to_s

  is_fake

  depends_on 'webkit2gtk_4'
  depends_on 'webkit2gtk_4_1'
  depends_on 'webkit2gtk_5'
end
