require 'package'

class Waf < Package
  description 'The Waf build system'
  homepage 'https://waf.io/'
  version '1.9.12'
  source_url 'https://github.com/waf-project/waf/archive/waf-1.9.12.tar.gz'
  source_sha256 '1d33490f421560fd5ddb9dcc523c3c50e9dba0146ffac3e5f8503149cc10252c'

  depends_on 'help2man'
  depends_on 'python27' unless File.exists? '/usr/local/bin/python'

  def self.build
    system './waf-light configure build'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "help2man -N ./waf > waf.1"
    system "cp waf #{CREW_DEST_DIR}/usr/local/bin"
    system "cp waf.1 #{CREW_DEST_DIR}/usr/local/man/man1"
  end
end
