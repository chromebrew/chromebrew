require 'package'
require_relative 'desktop_file_utils'

class Desktop_file_utilities < Package
  description Desktop_file_utils.description
  homepage Desktop_file_utils.homepage
  version Desktop_file_utils.version
  license Desktop_file_utils.license
  compatibility Desktop_file_utils.compatibility

  is_fake

  depends_on 'desktop_file_utils'
end
