require 'package'

class Sejda_console < Package
  description 'Sejda SDK is an open source, task oriented Java library to edit PDF files.'
  homepage 'http://sejda.org/'
  version '3.2.85'
  license 'AGPL-3'
  compatibility 'all'
  source_url 'https://github.com/torakiki/sejda/releases/download/v3.2.85/sejda-console-3.2.85-bin.zip'
  source_sha256 'a2380aff1904103317a92b61a2008e2018184de0a7ed58e2516bd1b3818a48bf'

  depends_on 'help2man' => :build
  depends_on 'unzip' => :build
  depends_on 'openjdk8'

  no_compile_needed

  def self.build
    @sejda = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/sejda_console
      exec bin/sejda-console "$@"
    EOF
    File.write 'sejda-console', @sejda
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.mkdir_p "#{CREW_PREFIX}/share/sejda_console"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sejda_console"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/sejda_console"
    FileUtils.install 'sejda-console', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.cp_r '.', "#{CREW_PREFIX}/share/sejda_console"
    system "help2man -N --no-discard-stderr #{CREW_DEST_PREFIX}/bin/sejda-console > #{CREW_DEST_MAN_PREFIX}/man1/sejda-console.1"
    FileUtils.rm_rf "#{CREW_PREFIX}/share/sejda_console"
  end
end
