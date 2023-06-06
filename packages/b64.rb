require 'package'

class B64 < Package
  description 'Base64 Encode/Decode Utility'
  homepage 'https://base64.sourceforge.net/'
  version '0.94'
  license 'MIT'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/base64/b64.0.94.zip'
  source_sha256 '72a5d8c4dd3d197d7ac655d2def13d5b41cd41b831dbf5b5d3509f4aaff6b669'

  depends_on 'gcc_lib' => :build

  def self.build
    system 'gcc -o b64 b64.c'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_PREFIX}/bin"
    FileUtils.install 'b64', "#{CREW_PREFIX}/bin", mode: 0o755
  end
end
