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
    aarch64: '56bf4308e78c4b5ef81289118452f2cbc7fabfc872bacd6cbed42f42ee4afd86',
     armv7l: '56bf4308e78c4b5ef81289118452f2cbc7fabfc872bacd6cbed42f42ee4afd86',
       i686: '557efd11b3b8ef2ec4ca9e8c9fc256a7c83ada457f36eccd3aa53877f8c105e6',
     x86_64: 'ef58935c98389edfb7819eb31f3ffed503a4e02f317609fa7bfb9958e4936757'
  })

  depends_on 'bash' # L

  conflicts_ok # Conflicts with uutils_coreutils.
end
