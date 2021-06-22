require 'package'

class Libcom_err < Package
  description 'Common error description library'
  homepage 'http://e2fsprogs.sourceforge.net/'
  version '1.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'e2fsprogs'

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    Dir.chdir CREW_DEST_LIB_PREFIX do
      FileUtils.symlink "#{CREW_LIB_PREFIX}/libcom_err.so.2.1", 'libcom_err.so.3'
    end
  end
end
