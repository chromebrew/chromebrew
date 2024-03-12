# Adapted from Arch Linux git-tools-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=git-tools-git

require 'package'

class Git_mestrelion_tools < Package
  description 'Assorted git tools, including git-restore-mtime'
  homepage 'https://github.com/MestreLion/git-tools'
  @_ver = '2022.12'
  version "#{@_ver}-1"
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/MestreLion/git-tools.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9cd005b5739d50dcc7fe4e50d38c1b51e372ebc0bbf03ee36d3dbf042011db8',
     armv7l: 'e9cd005b5739d50dcc7fe4e50d38c1b51e372ebc0bbf03ee36d3dbf042011db8',
       i686: '79f534b94ff2c6b80aaf8eb829d3d9717f4a94c61fe3253f63bd64baa71a117f',
     x86_64: '704dee30d25eda119b3f816f9b407f02dca6f7ee385d8ee173f2419abe7f2ba6'
  })

  depends_on 'git' # L
  depends_on 'python3' # R

  def self.build
    @post_merge_hook = <<~POST_MERGE_HOOK_EOF
      #!/bin/sh
      # This is from the git_mestrelion_tools package.
      exec git-restore-mtime -sq 2>/dev/null
    POST_MERGE_HOOK_EOF
    File.write('post-merge', @post_merge_hook)
  end

  def self.install
    Dir.glob('man1/*.1') do |man|
      FileUtils.install man, "#{CREW_DEST_MAN_PREFIX}/#{man}", mode: 0o644
    end
    Dir.glob('git-*') do |app|
      FileUtils.install app, "#{CREW_DEST_PREFIX}/bin/#{app}", mode: 0o755
    end
    @crew_dest_lib_path = File.join(CREW_DEST_DIR, CREW_LIB_PATH)
    FileUtils.install 'post-merge', File.join(@crew_dest_lib_path, '.git/hooks/post-merge'), mode: 0o755
  end

  def self.postinstall
    # restore mtime after install.
    Dir.chdir(CREW_LIB_PATH) do
      system 'git-restore-mtime -s 2>/dev/null'
    end
  end
end
