require 'buildsystems/autotools'

class Cloog < Autotools
  description 'The CLooG Code Generator in the Polytope Model'
  homepage 'https://github.com/periscop/cloog'
  version '0.21.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/periscop/cloog.git'
  git_hashtag "cloog-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94adbe0a434c3217aea0f8e046487c8fa22f9cfae217afe5497eb5bf89ad17b0',
     armv7l: '94adbe0a434c3217aea0f8e046487c8fa22f9cfae217afe5497eb5bf89ad17b0',
       i686: 'edde9896159ba206e68dea645463f480b9a010b52f34a07cf2115bed27bbb919',
     x86_64: '39e04e2dcad00ccb3a7f9dceeccb7c781320fc738c415830cdefeca3d669ca35'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'isl'
  depends_on 'osl'

  autotools_configure_options '--with-isl=system --with-osl=system'
  run_tests
end
