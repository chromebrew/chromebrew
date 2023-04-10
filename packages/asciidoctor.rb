require 'package'
require_relative 'ruby_asciidoctor'

class Asciidoctor < Package
  description Ruby_asciidoctor.description.to_s
  homepage Ruby_asciidoctor.homepage.to_s
  version Ruby_asciidoctor.version.to_s
  license Ruby_asciidoctor.license.to_s
  compatibility Ruby_asciidoctor.compatibility.to_s

  is_fake

  depends_on 'ruby_asciidoctor'
end
