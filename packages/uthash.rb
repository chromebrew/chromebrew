require 'package'

class Uthash < Package
  description 'A hash table for C structures'
  homepage 'https://troydhanson.github.com/uthash/'
  version '2.1.0'
  compatibility 'all'
  source_url 'https://github.com/troydhanson/uthash/archive/v2.1.0.tar.gz'
  source_sha256 '152ccd8e64d0f495377232e3964d06c7ec8bb8c3fbd3217f8a5702614f9a669e'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/"
    FileUtils.cp_r Dir.glob('./src/*'), "#{CREW_DEST_PREFIX}/include/"
  end
end
