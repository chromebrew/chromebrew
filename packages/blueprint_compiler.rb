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
    aarch64: '65f0002a675539fdeac82323ebe436761673fec240bf4c08607205dca5cb30fb',
     armv7l: '65f0002a675539fdeac82323ebe436761673fec240bf4c08607205dca5cb30fb',
     x86_64: 'b2a25f0848dcb6f1668620dbc1459393d2d67fb6b7b6ca93d288d02773309f2b'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' => :build
  depends_on 'py3_pygobject' => :logical

  def self.patch
    patches = [
      # https://gitlab.gnome.org/GNOME/blueprint-compiler/-/work_items/254
      ['https://gitlab.gnome.org/GNOME/blueprint-compiler/-/merge_requests/314.diff',
       'f42df751f5a8bfc853faf67fddac33fe162afae71e9212021e1595b558c9d556']
    ]
    ConvenienceFunctions.patch(patches) if version.gsub("-#{CREW_PY_VER}", '').include?('0.22')
  end

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
    output = `PYTHONPATH=#{CREW_DEST_PREFIX}/lib/python3.14/site-packages #{CREW_DEST_PREFIX}/bin/blueprint-compiler compile #{testpath}/test.blp`.chomp
    abort "#{name} test error".lightred unless output.include?('Hello, Blueprint!')
  end
end
