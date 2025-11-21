require 'package'

class Container_essential < Package
  description 'A collection of extra tools and packages needed in the docker build containers.'
  homepage 'https://github.com/chromebrew/chromebrew'
  version '1.1'
  license 'GPL-3+'
  compatibility 'all'

  is_fake

  # Add docbook to make sure that docbook environment variables are set
  # for manpage generation in many packages,
  depends_on 'docbook'

  depends_on 'psmisc'
  depends_on 'sudo_rs'
  # xxd is used to pass arguments into the container to the /bin/chromebrewstart docker container start CMD.
  depends_on 'xxd_standalone'
  depends_on 'util_linux'

  if CREW_GLIBC_INTERPRETER.nil?
    depends_on 'gawk'
    depends_on 'jq'
    depends_on 'libeconf'
    depends_on 'libxcrypt'
    depends_on 'tar'
    depends_on 'which'
  end
  depends_on 'uutils_coreutils' unless ARCH == 'i686'

  # Add pax_utils (gives us lddtree)
  depends_on 'pax_utils'
  # Pax_utils needs this.
  depends_on 'py3_pyelftools'

  # Ruby gems
  # Add ruby_concurrent_ruby
  depends_on 'ruby_concurrent_ruby'
  # Needed for irb
  depends_on 'ruby_debug'
  # Needed for buildsystems reporting.
  depends_on 'ruby_method_source'
  # For crew debugging.
  depends_on 'ruby_pry_byebug'
  # Add rubocop for linting packages. (This also installs the
  # rubocop config file.)
  depends_on 'ruby_rubocop'
  depends_on 'ruby_rubocop_chromebrew'
  depends_on 'ruby_ruby_libversion'
end
