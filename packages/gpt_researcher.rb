require 'package'
Package.load_package("#{__dir__}/py3_gpt_researcher.rb")

class Gpt_researcher < Package
  description Py3_gpt_researcher.description
  homepage Py3_gpt_researcher.homepage
  version Py3_gpt_researcher.version
  license Py3_gpt_researcher.license
  compatibility Py3_gpt_researcher.compatibility

  is_fake

  depends_on 'py3_gpt_researcher'
end
