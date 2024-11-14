require 'package'
Package.load_package("#{__dir__}/ruby_asciidoctor.rb")

class Asciidoctor < Package
  description Ruby_asciidoctor.description
  homepage Ruby_asciidoctor.homepage
  version Ruby_asciidoctor.version
  license Ruby_asciidoctor.license
  compatibility Ruby_asciidoctor.compatibility

  is_fake

  depends_on 'ruby_asciidoctor'
end
