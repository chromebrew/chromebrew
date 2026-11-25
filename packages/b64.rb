require 'package'

class B64 < Package
  description 'Base64 Encode/Decode Utility'
  homepage 'https://base64.sourceforge.net/'
  version '0.94'
  license 'MIT'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/base64/b64.#{version}.zip"
  source_sha256 '72a5d8c4dd3d197d7ac655d2def13d5b41cd41b831dbf5b5d3509f4aaff6b669'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ca68194359e69e68ab37cc9b821094236f4a8237a652fbf6de643448410ebc2',
     armv7l: '7ca68194359e69e68ab37cc9b821094236f4a8237a652fbf6de643448410ebc2',
       i686: '6b375bd94313a5424a21c5b418e986d358a26e146e5dc364b6d91ba7436d2bc9',
     x86_64: 'c53b3f213ca84ec18cafcce30f8e44a43540f620046ff8bd0ecdc0a42efe05b2'
  })

  depends_on 'gcc_lib' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.build
    system 'gcc -o b64 b64.c'
  end

  def self.install
    FileUtils.install 'b64', "#{CREW_DEST_PREFIX}/bin/b64", mode: 0o755
  end
end
