require 'package'

class Mlocate < Package
  description 'mlocate is a locate/updatedb implementation.'
  homepage 'https://pagure.io/mlocate/'
  version '0.26-2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://releases.pagure.org/mlocate/mlocate-0.26.tar.xz'
  source_sha256 '3063df79fe198fb9618e180c54baf3105b33d88fe602ff2d8570aaf944f1263e'

  def self.patch
      @updatedb_wrapper = <<~EOF
      #!/bin/bash -e
      if [ "${EUID}" = 0 ]; then
        echo "updatedb should not be run as root on ChromeOS."
        exit 1
      else
        #{CREW_PREFIX}/bin/updatedb.real "${@}"
      fi
    EOF
    IO.write("updatedb.sh", @updatedb_wrapper)
  end

  def self.build
    system "sed -i 's:groupname = mlocate:groupname = #{USER}:g' Makefile.*"
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/bin/updatedb", "#{CREW_DEST_PREFIX}/bin/updatedb.real"
    FileUtils.install "updatedb.sh", "#{CREW_DEST_PREFIX}/bin/updatedb", mode: 0755
  end
  
  def self.check
    system 'make', 'check'
  end
end
