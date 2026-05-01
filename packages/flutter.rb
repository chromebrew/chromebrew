require 'package'

class Flutter < Package
  description "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase."
  homepage 'https://flutter.dev/'
  version '3.41.9'
  license 'BSD-3'
  compatibility 'x86_64'
  source_url "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_#{version}-stable.tar.xz"
  source_sha256 'cf2631dde02570733921a530f47a96abe896b5e334682d2743c29530ea88bb2e'

  depends_on 'libglu'

  conflicts_with 'dart'
  no_compile_needed
  no_shrink

  def self.preflight
    # Need at least 3.65 GB of free disk space to install.
    MiscFunctions.check_free_disk_space(3919157657)
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_HOME
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/flutter"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/flutter"
    FileUtils.touch "#{CREW_DEST_HOME}/.flutter_tool_state"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/flutter/bin/dart", "#{CREW_DEST_PREFIX}/bin/dart" unless File.exist? "#{CREW_PREFIX}/bin/dart"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/flutter/bin/flutter", "#{CREW_DEST_PREFIX}/bin/flutter"
  end

  def self.postinstall
    ExitMessage.add "\nType 'flutter' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.flutter")
    Package.agree_to_remove("#{CREW_PREFIX}/share/flutter")
  end
end
