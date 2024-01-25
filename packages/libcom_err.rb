require 'package'

class Libcom_err < Package
  description 'Common error description library'
  homepage 'http://e2fsprogs.sourceforge.net/'
  version '1.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: '095f677281ab9607b311c2f20dc00155a6e028a9f092165931076368cfd86cee',
     armv7l: '095f677281ab9607b311c2f20dc00155a6e028a9f092165931076368cfd86cee',
       i686: '43122aecc251b9f04db3a74c254fbc9facedd58e57948e5376a244f9e4eb8fdd',
     x86_64: '689493df8fde02e772e09f62693150f1ea4e0d87ee7961b01207b9cdb6017c9a'
  })

  depends_on 'e2fsprogs'

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    Dir.chdir CREW_DEST_LIB_PREFIX do
      FileUtils.ln_s 'libcom_err.so.2.1', 'libcom_err.so.3'
    end
  end
end
