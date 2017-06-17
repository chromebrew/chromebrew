require 'package'

class Ranger < Package # the name of the package
  version '1.8.1' # the current version of the package
  source_url 'https://github.com/ranger/ranger/archive/v1.8.1.tar.gz' # the source files for the package
  source_sha1 '8948bc749cf91297da6dcf7b275a72d17a0302f3'

  def self.build
   system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
end
