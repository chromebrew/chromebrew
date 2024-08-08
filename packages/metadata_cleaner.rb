require 'buildsystems/meson'

class Metadata_cleaner < Meson
  description 'Python GTK application to view and clean metadata in files, using mat2'
  homepage 'https://metadatacleaner.romainvigier.fr/'
  version '2.5.6'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://gitlab.com/rmnvgr/metadata-cleaner.git'
  git_hashtag "v#{version}"

  depends_on 'desktop_file_utils' # R
  depends_on 'gtk4' # R
  depends_on 'itstool' # R
  depends_on 'libadwaita' # R
  depends_on 'mesonbuild' => :build
  depends_on 'py3_mat2' # R
  depends_on 'pygobject' # R
  depends_on 'python3' # R

  no_compile_needed

  def self.postinstall
    ExitMessage.add "\nType 'metadata-cleaner' to get started.\n"
  end
end
