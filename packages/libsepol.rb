require 'package'

class Libsepol < Package
  description 'SEPolicy Libraries for Chrome OS'
  homepage 'https://github.com/SELinuxProject/selinux/'
  version '2.8'
  source_url 'https://github.com/SELinuxProject/selinux/archive/libsepol-2.8.tar.gz'
  source_sha256 'de81b76118f958150b559b406caa36131a373921eb51c379a266747585744e48'

  depends_on 'glibc_headers' => :build

  def self.build
    Dir.chdir ("libsepol") do
      system 'make'
    end
  end

  def self.install
    Dir.chdir ("libsepol") do
      system "make", "LIBDIR=#{CREW_LIB_PREFIX}", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
