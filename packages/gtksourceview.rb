require 'package'
Package.load_package("#{__dir__}/gtksourceview_3.rb")
Package.load_package("#{__dir__}/gtksourceview_4.rb")
Package.load_package("#{__dir__}/gtksourceview_5.rb")

class Gtksourceview < Package
  description Gtksourceview_3.description
  homepage Gtksourceview_3.homepage
  version "#{Gtksourceview_3.version}+#{Gtksourceview_4.version}+#{Gtksourceview_5.version}"
  license Gtksourceview_3.license
  compatibility Gtksourceview_3.compatibility

  is_fake

  depends_on 'gtksourceview_3'
  depends_on 'gtksourceview_4'
  depends_on 'gtksourceview_5'
end
