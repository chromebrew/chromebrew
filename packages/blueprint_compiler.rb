require 'buildsystems/meson'

class Blueprint_compiler < Meson
  description 'A markup language for GTK user interfaces'
  homepage 'https://gitlab.gnome.org/GNOME/blueprint-compiler'
  version "0.22.2-#{CREW_PY_VER}"
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/blueprint-compiler.git'
  git_hashtag "v#{version.gsub("-#{CREW_PY_VER}", '')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0dd0bc6e7f8a795639f3a31c780db6d3a85a0d6a35daa2a138ba9ddeddc1d86f',
     armv7l: '0dd0bc6e7f8a795639f3a31c780db6d3a85a0d6a35daa2a138ba9ddeddc1d86f',
     x86_64: 'f184ac27c9f4b8d5337f5feaf4a68d368e9e08482af887bce53124761eb9ef87'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' => :build
  depends_on 'py3_pygobject' => :logical

  def self.check
    # From: https://github.com/Homebrew/homebrew-core/blob/12f0265ccfd2a9eaf66cf94733acd79a88572ad2/Formula/b/blueprint-compiler.rb
    testpath = `pwd`.chomp
    File.write "#{testpath}/test.blp", <<~BLUEPRINT
      using Gtk 4.0;

      template $MyAppWindow: ApplicationWindow {
        default-width: 600;
        default-height: 300;
        title: _("Hello, Blueprint!");

        [titlebar]
        HeaderBar {}

        Label {
          label: bind template.main_text;
        }
      }
    BLUEPRINT
    output = `PYTHONPATH=#{CREW_DEST_PREFIX}/lib/python#{CREW_PY_VER.split('y')[1]}/site-packages #{CREW_DEST_PREFIX}/bin/blueprint-compiler compile #{testpath}/test.blp`.chomp
    abort "#{name} test error".lightred unless output.include?('Hello, Blueprint!')
  end
end
