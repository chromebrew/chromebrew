require 'package'

class Serf < Package
  description 'The serf library is a high performance C-based HTTP client library built upon the Apache Portable Runtime (APR) library.'
  homepage 'https://serf.apache.org/'
  version '1.3.9'
  source_url 'https://www.apache.org/dist/serf/serf-1.3.9.tar.bz2'
  source_sha1 '26015c63e3bbb108c1689bf2090e4c26351db674'

  depends_on 'scons'
  depends_on 'aprutil'

  def self.build
    nil
  end

  def self.install
    system "scons APR=/usr/local APU=/usr/local PREFIX=#{CREW_DEST_DIR} install"
  end
end
