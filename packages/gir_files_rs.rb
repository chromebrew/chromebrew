require 'package'

class Gir_files_rs < Package
  description 'GObject-Introspection (.gir) files used for the GStreamer Rust bindings'
  homepage 'https://gitlab.freedesktop.org/gstreamer/gir-files-rs'
  version '0.24.3'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/gstreamer/gir-files-rs.git'
  git_hashtag version

  depends_on 'xmlstarlet'

  no_compile_needed

  def self.patch
    system './fix.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gir-1.0"
    FileUtils.mv Dir['*.gir'], "#{CREW_DEST_PREFIX}/share/gir-1.0"
  end
end
