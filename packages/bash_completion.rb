require 'buildsystems/autotools'

class Bash_completion < Autotools
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.16.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b144439590fdc6dea667c35d40e816eb872dda828dc4d5129fd4244e7a2fd4bb',
     armv7l: 'b144439590fdc6dea667c35d40e816eb872dda828dc4d5129fd4244e7a2fd4bb',
       i686: 'cb0932c71faa7e6c5c4a7771fc61a72ce1b79990219be04db4d8a742c36f38bd',
     x86_64: 'ff10f76bdc6d113c4bb26458d01e79270965402b3fdfe1d9f39f6d49589ac7c2'
  })

  depends_on 'bash' # L

  # Handle conflicts with uutils_coreutils.
  autotools_install_extras do
    %w[
      arch
      b2sum
      chgrp
      chmod
      chown
      dd
      env
      hostname
      id
      kill
      md5sum
      mktemp
      nproc
      printenv
      pwd
      sha1sum
      sha224sum
      sha256sum
      sha384sum
      sha512sum
      timeout
      truncate
    ].each do |completion|
      FileUtils.mv "#{CREW_DEST_PREFIX}/share/bash-completion/completions/#{completion}", "#{CREW_DEST_PREFIX}/share/bash-completion/completions/#{completion}_bash"
    end
  end
end
