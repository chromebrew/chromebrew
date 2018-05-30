require 'package'

class Libselinux < Package
  description 'SELinux Headers for Chrome OS'
  homepage 'https://selinuxproject.org/page/LibselinuxAPISummary'
  version '2.8'
  source_url 'https://github.com/SELinuxProject/selinux/archive/libselinux-2.8.tar.gz'
  source_sha256 'b2b2efff29e457dc8ee6834e0df49571b54246d65ef21e88f8374abf7524598e'

#  depends_on 'libsepol'
#  depends_on 'glibc_headers'
#  depends_on 'pcre' => :build

  def self.build
    system "echo", "OK"
  end

  def self.install
    Dir.chdir ("libselinux/include") do
      system "make", "install", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}"
    end
  end
end
