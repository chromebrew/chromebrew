require 'package'
require_relative 'desktop_file_utils'

class Desktop_file_utilities < Package
  description Desktop_file_utils.descripton.to_s
  homepage Desktop_file_utils.homepage.to_s
  version Desktop_file_utils.version.to_s
  license Desktop_file_utils.license.to_s
  compatibility Desktop_file_utils.compatibility.to_s

  is_fake

  depends_on 'desktop_file_utils'
end
