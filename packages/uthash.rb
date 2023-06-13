require 'package'

class Uthash < Package
  description 'A hash table for C structures'
  homepage 'https://troydhanson.github.com/uthash/'
  version '2.3.0'
  license 'BSD-1'
  compatibility 'all'
  source_url 'https://github.com/troydhanson/uthash/archive/v2.3.0.tar.gz'
  source_sha256 'e10382ab75518bad8319eb922ad04f907cb20cccb451a3aa980c9d005e661acc'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/include/"
    FileUtils.cp_r './src/*', "#{CREW_DEST_PREFIX}/include/"
  end
end
