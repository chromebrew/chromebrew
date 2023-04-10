require 'package'
require_relative 'gtksourceview_3'
require_relative 'gtksourceview_4'
require_relative 'gtksourceview_5'

class Gtksourceview < Package
  description Gtksourceview_3.description.to_s
  homepage Gtksourceview_3.homepage.to_s
  version "#{Gtksourceview_3.version}+#{Gtksourceview_4.version}+#{Gtksourceview_5.version}"
  license Gtksourceview_3.license.to_s
  compatibility Gtksourceview_3.compatibility.to_s

  is_fake

  depends_on 'gtksourceview_3'
  depends_on 'gtksourceview_4'
  depends_on 'gtksourceview_5'
end
